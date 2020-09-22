/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200110 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLnSQYHr.aml, Mon Sep 21 21:01:03 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000155 (341)
 *     Revision         0x02
 *     Checksum         0xE8
 *     OEM ID           "ACDT"
 *     OEM Table ID     "BrightFN"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200110 (538968336)
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "BrightFN", 0x00000000)
{
    External (_SB_.PCI0.LPCB.HWEC, DeviceObj)
    External (_SB_.PCI0.LPCB.HWEC.XQ0A, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.HWEC.XQ0B, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Scope (_SB.PCI0.LPCB.HWEC)
    {
        Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                Notify (PS2K, 0x0205)
                Notify (PS2K, 0x0285)
            }
            Else
            {
                XQ0A ()
            }
        }

        Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                Notify (PS2K, 0x0206)
                Notify (PS2K, 0x0286)
            }
            Else
            {
                XQ0B ()
            }
        }
    }
}

