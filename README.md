### libbase
This dll contains very handy functions made for Windows X64 systems. In addition, these functions can be easily imported from C# and C/C++.
Singatures initially designed for C#.

## Usage
#### C#
Paste code above into your .cs file, and move .dll to build directory.

#### C++
Paste code into some header file, and link this dll accordingly to your compiler. (gcc/clang recommended)

## Note
In case of 'Random' functions, if you use numbers that are close to it's min/max type size, it'll output invalid number.

## C#
```csharp
public static unsafe class XLib {
    [DllImport("base.dll")]
    public static extern void FastZeroMemory(void *ptr, Int64 size);

    [DllImport("base.dll")]
    public static extern void FastSort(void *ptr, Int64 size);

    [DllImport("base.dll")]
    public static extern UInt64 Random64();

    [DllImport("base.dll")]
    public static extern UInt32 Random32();

    [DllImport("base.dll")]
    public static extern UInt16 Random16();
    
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

## C/C++
```cpp
extern "C" __declspec(dllimport) void FastZeroMemory(void *ptr, size_t size);
extern "C" __declspec(dllimport) void FastSort(void *ptr, size_t size);
extern "C" __declspec(dllimport) uint64_t Random64();
extern "C" __declspec(dllimport) uint32_t Random32();
extern "C" __declspec(dllimport) uint16_t Random16();
extern "C" __declspec(dllimport) int64_t RandomInt64(int64_t min, int64_t max);
extern "C" __declspec(dllimport) int32_t RandomInt32(int32_t min, int32_t max);
extern "C" __declspec(dllimport) int16_t RandomInt16(int16_t min, int16_t max);
extern "C" __declspec(dllimport) int8_t RandomSByte(int8_t min, int8_t max);
extern "C" __declspec(dllimport) uint8_t RandomByte(uint8_t min, uint8_t max);
extern "C" __declspec(dllimport) double RandomDouble(double min, double max);
extern "C" __declspec(dllimport) float RandomSingle(float min, float max);
```
