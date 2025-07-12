### libbase
This dll contains very handy functions. In addition, these functions can be easily imported from C#.


```csharp
public static unsafe class XLib {
    [DllImport("base.dll")]
    public static extern void FastZeroMemory(void* ptr, Int64 size);
    
    [DllImport("base.dll")]
    public static extern Int64 RandomInt64(Int64 min, Int64 max);
    
    [DllImport("base.dll")]
    public static extern Int32 RandomInt32(Int32 min, Int32 max);
        
    [DllImport("base.dll")]
    public static extern Int16 RandomInt16(Int16 min, Int16 max);
    
    [DllImport("base.dll")]
    public static extern Byte RandomByte(Byte min, Byte max);
    
    [DllImport("base.dll")]
    public static extern SByte RandomSByte(SByte min, SByte max);
    
    [DllImport("base.dll")]
    public static extern Double RandomDouble(Double min, Double max);
    
    [DllImport("base.dll")]
    public static extern Single RandomSingle(Single min, Single max);
}
```
