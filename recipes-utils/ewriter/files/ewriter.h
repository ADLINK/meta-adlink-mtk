/* Copyright Statement:
 *
 * This software/firmware and related documentation ("MediaTek Software") are
 * protected under relevant copyright laws. The information contained herein
 * is confidential and proprietary to MediaTek Inc. and/or its licensors.
 * Without the prior written permission of MediaTek inc. and/or its licensors,
 * any reproduction, modification, use or disclosure of MediaTek Software,
 * and information contained herein, in whole or in part, shall be strictly prohibited.
 */
/* MediaTek Inc. (C) 2022. All rights reserved.
 *
 * BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
 * THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
 * RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
 * AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
 * NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
 * SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
 * SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
 * THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
 * THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
 * CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
 * SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
 * STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
 * CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
 * AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
 * OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
 * MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
 *
 * The following software/firmware and/or related documentation ("MediaTek Software")
 * have been modified by MediaTek Inc. All revisions are subject to any receiver's
 * applicable license agreements with MediaTek Inc.
 */

#ifndef __EFUSE__
#define __EFUSE__

typedef unsigned char u8;
typedef unsigned int u32;


/* efuse status code */
#define TZ_EFUSE_OK                0    /* eFuse is ok */
#define TZ_EFUSE_BUSY              1    /* eFuse is busy */
#define TZ_EFUSE_INVAL             2    /* input parameters is invalid */
#define TZ_EFUSE_LEN               3    /* incorrect length of eFuse value */
#define TZ_EFUSE_ZERO_VAL          4    /* can't write a zero efuse value */
#define TZ_EFUSE_WRITE_DENIED      5    /* the eFuse can't be written */
#define TZ_EFUSE_SENS_WRITE        6    /* "sensitive write" is not allowed */
#define TZ_EFUSE_ACCESS_TYPE       7    /* incorrect eFuse access type */
#define TZ_EFUSE_BLOWN             8    /* the eFuse has been blown */
#define TZ_EFUSE_NOT_IMPLEMENTED   9    /* a eFuse feature is not implemented */
#define TZ_EFUSE_READ_AFTER_WRITE  10   /* check eFuse read failed after eFuse is written */
#define TZ_EFUSE_TOKEN_INVAL       11   /* token's eFuse value and lenth is not match with that defined in function "efuse_write" */
#define TZ_EFUSE_TOKEN_MAGIC       12   /* incorrect magic number in token */
#define TZ_EFUSE_TOKEN_HRID        13   /* incorrect hardware random id  in token */
#define TZ_EFUSE_BUSY_LOCK         14   /* eFuse is locking */
#define TZ_EFUSE_INV_CMD           15   /* the eFuse command is invalid */
#define TZ_EFUSE_INV_SETTING       16   /* the eFuse setting is invalid */
#define TZ_EFUSE_RES               17   /* resource problem duing eFuse operation */
#define TZ_EFUSE_VAL_OUT_SPEC      18   /* input eFuse value is out of sepcification */
#define TZ_EFUSE_PUBK_FAILED       19   /* failed to verify public key */
#define TZ_EFUSE_SIG_FAILED        20   /* failed to verify signature */

#define HRID_LEN 8

/**
 * struct UnitSpecificWriteToken - the token format for unit_specific_write
 *
 * @magic:        constant 0x719ea32c in big endian
 * @length:       length of rest of this message in big endian
 * @hrid:         HRID fuse value
 * @fuse_idx:     fuse index in big endian
 * @fuse_val_len: byte length of fuse value, must match arg in teeFuseWrite
 * @fuse_val:     the fuse value, must match arg in teeFuseWrite
 * @pub_key:      RSA public key in PKCS#8 DER format
 * @sig:          RSA w/ SHA256 signature and PSS padding over all previous fields
 *
 */
typedef struct {
    u32 magic;
    u32 length;
    u8 hrid[HRID_LEN];
    u32 fuse_idx;
    u8 fuse_val_len;
    u8 fuse_val[1];
    u8 pub_key[294];
    u8 sig[2048/8];
} __attribute__((packed)) UnitSpecificWriteToken;

/**
 * tee_fuse_write_start - send the command to start to write efuse
 *
 * Initialize efuse hardware before writing data to efuse hardware
 *
 * Return: Return 0 if the command is done, otherwise it is failed
 */
int tee_fuse_write_start(void);

/**
 * tee_fuse_write_end - send the command to end to write efuse
 *
 * Initialize efuse hardware after writing data to efuse hardware
 *
 * Return: Return 0 if the command is done, otherwise it is failed
 */
int tee_fuse_write_end(void);

/**
 * tee_fuse_no_more_sensitive_writes - send the command to disallow sensitive data
 *
 * From that call until the next boot the writes are disallowed
 *
 * Return: Return 0 if the command is done, otherwise it is failed
 */
int tee_fuse_no_more_sensitive_writes(void);

/**
 * tee_fuse_read - read data from efuse hardware
 *
 * @fuse:   the efuse index
 * @data:   the data storing the returned efuse data
 * @len:    the data length in byte
 *
 * Return: Return 0 if the command is done, otherwise it is failed.
 */
int tee_fuse_read(u32 fuse, u8 *data, size_t len);

/**
 * tee_fuse_write - write data to efuse hardware
 *
 * @fuse:                   the efuse index
 * @data:           the data writing to efuse
 * @len:                the data length in byte
 * @UnitSpecificWriteToken: the token format for unit_specific_write (optional)
 *
 * Return: Return 0 if the command is done, otherwise it is failed.
 */
int tee_fuse_write(u32 fuse, const u8 *data, size_t len);

/**
 * tee_fuse_error - show the readable string for efuse status code
 *
 * @result:  the efuse status code
 *
 * Return: Return "eFuse is ok." if the operation is successful, otherwise it is failed.
 */
const char *tee_fuse_error(int result);
#endif /* __EFUSE__ */
