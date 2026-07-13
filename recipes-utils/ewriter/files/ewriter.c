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

#include <ctype.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "ewriter.h"

enum efuse_test_cmd {
    EFUSE_READ = 0,
    EFUSE_WRITE,
    EFUSE_NO_MORE_SENS_DATA,
    EFUSE_CMD_NUM
};

static void hex_dump(const char *prefix, unsigned char *buf, int len)
{
    int i;

    if(!buf || !len)
        return;

    printf("%s:\n", prefix);
    for(i=0; i<len; i++) {
        if(i!=0 && !(i%16))
            printf("\n");
        printf("%02x", *(buf + i));
    }
    printf("\n");
}

static unsigned char nibbleFromChar(char c)
{
    if(c >= '0' && c <= '9') return c - '0';
    if(c >= 'a' && c <= 'f') return c - 'a' + 10;
    if(c >= 'A' && c <= 'F') return c - 'A' + 10;

    return 255;
}

/* Convert a string of characters representing a hex buffer into a series of bytes of that real value */
static unsigned char *hexStringToBytes(char *inhex, unsigned int efuse_len)
{
    unsigned char *retval;
    unsigned char *p;
    int len, i;
    int str_len = strlen(inhex);
    unsigned char odd;

    for (i=0;i<str_len;i++)
        if (!isxdigit(*(inhex+i))) {
            printf("please input hex value\n");
            return NULL;
        }

    odd = (str_len % 2);
    len = odd?(str_len / 2) + 1:(str_len / 2);
    retval = (unsigned char *)malloc(efuse_len+1);
    if (!retval) {
        printf("hexStringToBytes mem alloc fail\n");
        return NULL;
    }
    memset(retval, 0, efuse_len+1);
    for(i=0, p = (unsigned char *) inhex; i<len; i++) {
        if (odd && i == (len - 1)) {
            printf("odd and last byte\n");
            retval[i] = nibbleFromChar(*p);
        } else {
            retval[i] = (nibbleFromChar(*p) << 4) | nibbleFromChar(*(p+1));
            p += 2;
        }
    }

    retval[len] = 0;

    return retval;
}

static void usage(char *main)
{
    printf("%s Usage:\n", main);
    printf("ewriter CMD INDEX LENGTH [VALUE in HEX]\n");
    printf("Mandatory and optional arguments.\n");
    printf("  CMD:    0(read) or 1(write).\n");
    printf("  INDEX:  the index number of an eFuse field.\n");
    printf("  LENGTH: the length of the eFuse index.\n");
    printf("  [VALUE in HEX]: the data in hex be written into the eFuse index,\n");
    printf("                  only valid in writing eFuse (CMD=1).\n");
    printf("The details about efuse index and length, please refer to platform ewriter user guide.\n");
    printf("Examples:\n");
    printf("(1) read efuse index 1 with byte length \"32\" -> ewriter 0 1 32\n");
    printf("(2) read efuse index 5 with byte length \"1\"  -> ewriter 0 5 1\n");
    printf("(3) write efuse index 1 with byte length \"32\"\n");
    printf("    -> ewriter 1 1 32 0000000011111111222222223333333344444444555555556666666677777777\n");
    printf("(4) write efuse index 5 -> ewriter 1 5 1 1\n");
    printf("\n");
}

#define EFUSE_ACTION 1
#define EFUSE_INDEX  2
#define EFUSE_LEN    3
#define EFUSE_VALUE  4
static unsigned char check_input_data(int argc, char *argv[])
{
    int cmd;

    if (argc > 6 || argc < 2)
        return 0;

    cmd = atoi(argv[EFUSE_ACTION]);
    if (cmd >= EFUSE_CMD_NUM)
        return 0;

    if ((cmd == EFUSE_NO_MORE_SENS_DATA) && (argc != 2))
        return 0;

    if ((cmd == EFUSE_READ)) {
        if (argc != 4)
        return 0;
    }

    if (cmd == EFUSE_WRITE) {
        if (argc < 5 || argc > 6) {
            return 0;
        }
    }

    return 1;
}

/* actoion (read/write/set no more sensitive data) , efuse index , efuse byte length, efuse value*/
void main(int argc, char *argv[]){
    int ret = 0, cmd, efuse_idx;
    unsigned int len;
    unsigned char efuse_buf[256], *efuse_value = NULL;

    if(!check_input_data(argc, argv))
        return usage(argv[0]);

    cmd = atoi(argv[EFUSE_ACTION]);

    switch (cmd) {
    case EFUSE_READ:
        efuse_idx = atoi(argv[EFUSE_INDEX]);
        len = atoi(argv[EFUSE_LEN]);
        ret = tee_fuse_read(efuse_idx, efuse_buf, len);
        if (ret) {
            printf("failed to read efuse\n ");
            break;
        }
        else
            hex_dump("efuse hex", efuse_buf, len);
        break;
    case EFUSE_WRITE:
        efuse_idx = atoi(argv[EFUSE_INDEX]);
        len = atoi(argv[EFUSE_LEN]);

        efuse_value = hexStringToBytes(argv[EFUSE_VALUE], len);
        if (!efuse_value) {
            printf("invalid efuse value %s\n", argv[EFUSE_VALUE]);
            return;
        }
        hex_dump("efuse hex", efuse_value, len);

        /* In here, it should enable "Fsource" (gpio control) for write operation */
        ret = tee_fuse_write_start();
        if (ret) {
            printf("failed to start to write efuse\n ");
            /* In here, it should disable "Fsource" (gpio control) for write operation */
            break;
        }
        ret = tee_fuse_write(efuse_idx, efuse_value, len);
        tee_fuse_write_end();
        /* In here it should disable "Fsource" (gpio control) for write operation */
        break;
    case EFUSE_NO_MORE_SENS_DATA:
        printf("efuse teeFuseNoMoreSensitiveWrites test!\n");
        ret  = tee_fuse_no_more_sensitive_writes();
        if (ret)
            printf("failed to set no more sensitive write\n");
        break;
    }

    if (efuse_value)
        free(efuse_value);

    printf("status code = %d, which means \"%s\"\n", ret, tee_fuse_error(ret));
    exit(0);
}
