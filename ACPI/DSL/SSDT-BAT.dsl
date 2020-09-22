DefinitionBlock ("", "SSDT", 2, "hack", "batt", 0x00000000)
{
    
    External (_SB_.PCI0.LPCB.HWEC, DeviceObj)
    External (_SB_.PCI0.LPCB.HWEC.ALSD, DeviceObj)
    External (_SB.PCI0.LPCB.HWEC.ALSD.ALRC, MethodObj)   
    External (_SB.PCI0.LPCB.HWEC.ALSD.ALSC, MethodObj)    
    External (_SB.PCI0.LPCB.HWEC.ALSD.GLOV, MethodObj)    
    External (_SB.PCI0.LPCB.HWEC.ALSD.GUPV, MethodObj)    
    External (_SB.PCI0.LPCB.HWEC.ALSD.X3PT, MethodObj)
    External (_SB.PCI0.LPCB.HWEC.ALSD.X3WK, MethodObj)    
    External (_SB.PCI0.LPCB.HWEC.ALSD.XINI, MethodObj)   
    External (_SB.PCI0.LPCB.HWEC.BALS, FieldUnitObj)
    External (_SB.PCI0.LPCB.HWEC.BAT0, DeviceObj)
    External (_SB.PCI0.LPCB.HWEC.BAT0.XATW, MethodObj) 
    External (_SB.PCI0.LPCB.HWEC.BAT0.XBIX, MethodObj)  
    External (_SB.PCI0.LPCB.HWEC.BAT0.XBST, MethodObj)    
    External (_SB.PCI0.LPCB.HWEC.EB0S, FieldUnitObj)
    External (EKVA, FieldUnitObj)
    External (_SB.PCI0.LPCB.HWEC.ECCD, MethodObj) 
    External (_SB.PCI0.LPCB.HWEC.ECMT, MutexObj)
    External (_SB.PCI0.LPCB.HWEC.EPWS, FieldUnitObj)
    External (_SB.PCI0.LPCB.HWEC.XCBM, MethodObj)   
    External (_SB.PCI0.LPCB.HWEC.XCRD, MethodObj)    
    External (_SB.PCI0.LPCB.HWEC.XCWT, MethodObj)    
    External (_SB.PCI0.LPCB.HWEC.XQA8, MethodObj)    
    External (_SB.PCI0.LPCB.HWEC.XQA9, MethodObj)   
    External (ADBG, MethodObj) 
    External (ECWT, MethodObj)    
    External (ECRD, MethodObj)    
    External (ALSC, MethodObj)    
    External (ECTK, IntObj)    
    External (ECAV, IntObj)    
    External (DVOT, IntObj)    
    External (SULV, IntObj)    
    External (SLLV, IntObj)    
    External (_SB.PCI0.LPCB.HWEC.ALSD.ALSI, IntObj)    
    External (ASKV, FieldUnitObj)
    External (NTOC, MethodObj)
    
    Method (B1B2, 2, NotSerialized) { Return(Or(Arg0, ShiftLeft(Arg1, 8))) }
    
Scope (_SB.PCI0.LPCB.HWEC)
    {    
    
    
          OperationRegion (ECWX, EmbeddedControl, Zero, 0xFF)
            Field (ECWX, ByteAcc, Lock, Preserve)
            {    
                Offset (0x92), 
                VL00,8, VL01,8, 
                RC00,8, RC01,8, 
                FC00,8, FC01,8, 
                ST00,8, ST01,8, 
                CC00,8, CC01,8, 
 
                Offset (0xA2),
                DC00,8, DC01,8, 
                DV00,8, DV01,8, 
                SN00,8, SN01,8, 
                Offset (0xAA),
                CT00,8, CT01,8,
                 
                Offset (0xEA), 
                ULV0,8, ULV1,8, 
                LLV0,8, LLV1,8, 
                CAL0,8, CAL1,8, 
                LUX0,8, LUX1,8
            }
            
            Method (ECRD, 1, Serialized)
            {
                If (_OSI ("Darwin"))
                {
                If (ECTK)
                {
                    ECTK = Zero
                }
                Local0 = Acquire (ECMT, 0x03E8)
                If ((Local0 == Zero))
                {
                    If (ECAV)
                    {
                        Local1 = DerefOf (Arg0)
                        Release (ECMT)
                        Return (Local1)
                    }
                    Else
                    {
                        Release (ECMT)
                    }
                }
                Return (Zero)
                }
                Else
                {
                    Return (XCRD (Arg0))
                }
            }
            
            Method (ECWT, 2, Serialized)
            {
                If (_OSI ("Darwin"))
                {
                If (ECTK)
                {
                    ECTK = Zero
                }
                Local0 = Acquire (ECMT, 0x03E8)
                If ((Local0 == Zero))
                {
                    If (ECAV)
                    {
                        Arg1 = Arg0
                    }
                    Release (ECMT)
                }
                }
                Else
                {
                XCWT (Arg0, Arg1)
                }
            }            
            
            
        Method (ECBM, 1, Serialized)
        {
            If (_OSI ("Darwin"))
            {
            Name (BMB1, Buffer (0x40){})
            If (LOr (LEqual (Arg0, Zero), LEqual (Arg0, One)))
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x8A, Local0)
                }

                If (LEqual (Arg0, One))
                {
                    Store (0x89, Local0)
                }

                Store (ECCD (Local0, 0x08, Buffer (0x08){}), BMB1)
                Store (DerefOf (Index (BMB1, One)), Local0)
                If (LNotEqual (Local0, Zero))
                {
                    Name (BMB2, Buffer (Add (Local0, One)){})
                    Store (Zero, Local2)
                    While (LLess (Local2, Local0))
                    {
                        Store (DerefOf (Index (BMB1, Add (Local2, 0x03))), Index (BMB2, Local2))
                        Increment (Local2)
                    }

                    Return (BMB2)
                }
            }

            If (LEqual (Arg0, 0x02))
            {
                Store (B1B2(ECRD (RefOf (SN00)), ECRD (RefOf (SN01))), Local0)
                Store (NTOC (Local0), Index (BMB1, 0x03))
                Store (NTOC (ShiftRight (Local0, 0x04)), Index (BMB1, 0x02))
                Store (NTOC (ShiftRight (Local0, 0x08)), Index (BMB1, One))
                Store (NTOC (ShiftRight (Local0, 0x0C)), Index (BMB1, Zero))
                Return (BMB1)
            }

            Return (Package (0x08)
            {
                0x55, 
                0x6E, 
                0x6B, 
                0x6E, 
                0x6F, 
                0x77, 
                0x6E, 
                Zero
            })
            }
            Else
            {
                Return (XCBM (Arg0))
            }
        }            
          
        Method (_QA8, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (_OSI ("Darwin"))
                {
            Store (B1B2(ECRD (RefOf (LUX0)), ECRD (RefOf (LUX1))), Local0)
            Store (^ALSD.ALSC (Local0), Local0)
            Store (Local0, ^ALSD.ALSI)
            ECWT (Local0, B1B2(RefOf (CAL0), RefOf (CAL1)))
            Store (^ALSD.GUPV (Local0), Local1)
            Store (^ALSD.GLOV (Local0), Local2)
            Store (^ALSD.ALRC (Local1), Local1)
            Store (^ALSD.ALRC (Local2), Local2)
            ECWT (Local1, B1B2(RefOf (ULV0), RefOf (ULV1)))
            ECWT (Local2, B1B2(RefOf (LLV0), RefOf (LLV1)))
            ECWT (One, RefOf (BALS))
            Notify (ALSD, 0x80)
            }
            Else
            {
                XQA8 ()
            }
        }

        Method (_QA9, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (_OSI ("Darwin"))
                {
            Store (ECRD (RefOf (EKVA)), Local3)
            Store (Local3, ASKV)
            Store (B1B2(ECRD (RefOf (LUX0)), ECRD (RefOf (LUX1))), Local0)
            Store (^ALSD.ALSC (Local0), Local0)
            Store (Local0, ^ALSD.ALSI)
            ECWT (Local0, B1B2(RefOf (CAL0), RefOf (CAL1)))
            Store (^ALSD.GUPV (Local0), Local1)
            Store (^ALSD.GLOV (Local0), Local2)
            Store (^ALSD.ALRC (Local1), Local1)
            Store (^ALSD.ALRC (Local2), Local2)
            ECWT (Local1, B1B2(RefOf (ULV0), RefOf (ULV1)))
            ECWT (Local2, B1B2(RefOf (LLV0), RefOf (LLV1)))
            ECWT (One, RefOf (BALS))
            Notify (ALSD, 0x80)
            ADBG ("Update-ALS-K")
            }
            Else
            {
                XQA9 ()
            }
        }            
            
            
              
    // HWEC Scope Closure
    }

    Scope (_SB.PCI0.LPCB.HWEC.BAT0)
    {
    
            Method (CATW, 1, Serialized)
            {
                If (_OSI ("Darwin"))
                {
                Multiply (Arg0, B1B2(ECRD (RefOf (DV00)), ECRD (RefOf (DV01))), Local0)
                Divide (Local0, 0x03E8, , Local1)
                Return (Local1)
                }
                Else
                {
                    Return (XATW (Arg0))
                }
            }    

    
            Method (_BIX, 0, Serialized)  // _BIX: Battery Information Extended
            {
                If (_OSI ("Darwin"))
                {
                Name (BPK1, Package (0x15)
                {
                    One, 
                    Zero, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    One, 
                    0xFFFFFFFF, 
                    Zero, 
                    Zero, 
                    0x64, 
                    0x00017318, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Zero, 
                    0x0100, 
                    0x40, 
                    "BASE-BAT", 
                    "123456789", 
                    "LION", 
                    "Simplo", 
                    Zero
                })
                If (LAnd (ECAV, LAnd (B1B2(ECRD (RefOf (DV00)), ECRD (RefOf (DV01))), LAnd (B1B2(ECRD (RefOf (DC00)), ECRD (RefOf (DC01))), B1B2(ECRD (RefOf (FC00)), ECRD (RefOf (FC01)))))))
                {
                    Store (B1B2(ECRD (RefOf (DV00)), ECRD (RefOf (DV01))), DVOT)
                    Store (CATW (B1B2(ECRD (RefOf (DC00)), ECRD (RefOf (DC01)))), Index (BPK1, 0x02))
                    Store (CATW (B1B2(ECRD (RefOf (FC00)), ECRD (RefOf (FC01)))), Index (BPK1, 0x03))
                    Store (DVOT, Index (BPK1, 0x05))
                    Store (Divide (Multiply (DerefOf (Index (BPK1, 0x03)), 0x05), 0x64, ), Index (BPK1, 0x06))
                    Store (Divide (Multiply (DerefOf (Index (BPK1, 0x03)), One), 0x64, ), Index (BPK1, 0x07))
                    Store (B1B2(ECRD (RefOf (CT00)), ECRD (RefOf (CT01))), Index (BPK1, 0x08))
                    Store (0x0320, Index (BPK1, 0x0B))
                    Store (0x251C, Index (BPK1, 0x0A))
                    Store (ToString (ECBM (Zero), Ones), Index (BPK1, 0x10))
                    Store (ToString (ECBM (0x02), Ones), Index (BPK1, 0x11))
                    Store (ToString (ECBM (One), Ones), Index (BPK1, 0x13))
                }

                Return (BPK1)
                }
                Else
                {
                    Return (XBIX ())
                }
            }

            Method (_BST, 0, Serialized)  // _BST: Battery Status
            {
                If (_OSI ("Darwin"))
                {
                Name (PKG1, Package (0x04)
                {
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF
                })
                If (ECAV)
                {
                    Store (B1B2(ECRD (RefOf (ST00)), ECRD (RefOf (ST01))), Local0)
                    Store (B1B2(ECRD (RefOf (CC00)), ECRD (RefOf (CC01))), Local1)
                    Store (B1B2(ECRD (RefOf (RC00)), ECRD (RefOf (RC01))), Local2)
                    Store (B1B2(ECRD (RefOf (VL00)), ECRD (RefOf (VL01))), Local3)
                    Store (ECRD (RefOf (EB0S)), Local4)
                    Store (Zero, Local5)
                    If (And (ECRD (RefOf (EPWS)), One))
                    {
                        If (LAnd (And (Local4, 0x02), LEqual (And (0x40, Local0), Zero)))
                        {
                            Or (0x02, Local5, Local5)
                        }
                        ElseIf (LAnd (And (0x40, Local0), And (0x8000, Local1)))
                        {
                            Or (One, Local5, Local5)
                        }
                    }
                    Else
                    {
                        Or (One, Local5, Local5)
                    }

                    If (And (0x0300, Local0))
                    {
                        Or (0x04, Local5, Local5)
                    }

                    If (LGreaterEqual (Local1, 0x8000))
                    {
                        Subtract (0xFFFF, Local1, Local1)
                        Add (One, Local1, Local1)
                    }

                    Store (Local5, Index (PKG1, Zero))
                    Store (CATW (Local1), Index (PKG1, One))
                    Store (CATW (Local2), Index (PKG1, 0x02))
                    Store (Local3, Index (PKG1, 0x03))
                }

                Return (PKG1)
                }
                Else
                {
                    Return (XBST ())
                }
            }       
            
            
            
            
            
             
                
    // BAT0 Scope Closure
    }

    Scope (_SB.PCI0.LPCB.HWEC.ALSD)
    {
    
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                If (_OSI ("Darwin"))
                {
                Store (B1B2(ECRD (RefOf (LUX0)), ECRD (RefOf (LUX1))), Local0)
                Store (ALSC (Local0), Local0)
                ECWT (Local0, B1B2(RefOf (CAL0), RefOf (CAL1)))
                Store (Local0, ALSI)
                Store (GUPV (Local0), Local1)
                Store (GLOV (Local0), Local2)
                Store (ALRC (Local1), Local1)
                Store (ALRC (Local2), Local2)
                ECWT (Local1, B1B2(RefOf (ULV0), RefOf (ULV1)))
                ECWT (Local2, B1B2(RefOf (LLV0), RefOf (LLV1)))
                ECWT (One, RefOf (BALS))
                }
                Else
                {
                    XINI ()
                }
            }    
    
            Method (S3WK, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                ECWT (SULV, B1B2(RefOf (ULV0), RefOf (ULV1)))
                ECWT (SLLV, B1B2(RefOf (LLV0), RefOf (LLV1)))
                ECWT (One, RefOf (BALS))
                }
                Else
                {
                    X3WK ()
                }
            }

            Method (S3PT, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                Store (B1B2(ECRD (RefOf (ULV0)), ECRD (RefOf (ULV1))), SULV)
                Store (B1B2(ECRD (RefOf (LLV0)), ECRD (RefOf (LLV1))), SLLV)
                }
                Else
                {
                    X3PT ()
                }
            }
    
            
    // ALSD Scope Closure
    }



// DefinitionBlock Scope Closure
}
