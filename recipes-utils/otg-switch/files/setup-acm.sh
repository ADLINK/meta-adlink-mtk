#!/bin/sh

USB_GADGET_G1=/sys/kernel/config/usb_gadget/g1
USB_GADGET_CONF=$USB_GADGET_G1/configs/c.1
USB_GADGET_FUNC=$USB_GADGET_G1/functions
UDC=$(ls /sys/class/udc | head -n 1)

#Unbind the gadget first
 echo "" > $USB_GADGET_G1/UDC

 # Set new PID
 echo 0x2010 > $USB_GADGET_G1/idProduct

 # Create ACM function if it doesn't exist
 if [ ! -d "$USB_GADGET_FUNC/acm.usb0" ]; then
     mkdir $USB_GADGET_FUNC/acm.usb0
     fi

     # Add ACM to config if not already linked
     if [ ! -e "$USB_GADGET_CONF/acm.usb0" ]; then
         # Note: relative path "acm.usb0" works here
             ln -s $USB_GADGET_FUNC/acm.usb0 $USB_GADGET_CONF/
             fi

             #Rebind gadget
             echo $UDC > $USB_GADGET_G1/UDC

# echo "ACM function added and gadget PID set to 0x2010"
             

