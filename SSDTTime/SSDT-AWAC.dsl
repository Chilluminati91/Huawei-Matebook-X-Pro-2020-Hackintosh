//
// SSDT-AWAC source from Acidanthera
// Originals found here:
//  - https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/SSDT-AWAC.dsl
//  - https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/SSDT-RTC0.dsl
//
// Uses the CORP name to denote where this was created for troubleshooting purposes.
//
DefinitionBlock ("", "SSDT", 2, "CORP", "AWAC", 0x00000000)
{
    External (\_SB.AWAC, DeviceObj)
    External (\_SB.AWAC.XSTA, MethodObj)
    Scope (\_SB.AWAC)
    {
        Name (ZSTA, 0x0F)
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            // Default to 0x0F - but return the result of the renamed XSTA if possible
            If ((CondRefOf (\_SB.AWAC.XSTA)))
            {
                Store (\_SB.AWAC.XSTA(), ZSTA)
            }
            Return (ZSTA)
        }
    }
}