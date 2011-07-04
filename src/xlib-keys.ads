
package Xlib.Keys is
    pragma Linker_Options ("-lX11");

    ShiftMask : constant := (2**0);
    LockMask : constant := (2**1);
    ControlMask : constant := (2**2);
    Mod1Mask : constant := (2**3);
    Mod2Mask : constant := (2**4);
    Mod3Mask : constant := (2**5);
    Mod4Mask : constant := (2**6);
    Mod5Mask : constant := (2**7);
end Xlib.Keys;
