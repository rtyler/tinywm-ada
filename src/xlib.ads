--
--  A minimalistic binding on top of the Xlib API, only enough to get TinyWM up
--  and running to be honest
--
--  The basis for all these bindings was a call of:
--      `gcc -fdump-ada-spec -C /usr/include/X11/Xlib.h`

with System,
     Interfaces.C,
     Interfaces.C.Strings;

package Xlib is
    pragma Linker_Options ("-lX11");
    use Interfaces.C;

    Null_Display : constant Interfaces.C.Strings.Chars_Ptr := Interfaces.C.Strings.Null_Ptr;
    Null_Atom : constant Interfaces.C.Int := 0;
    True : constant Interfaces.C.Int := 1;
    False : constant Interfaces.C.Int := 0;
    GrabModeSync : constant Interfaces.C.Int := 0;
    GrabModeAsync : constant Interfaces.C.Int := 1;

    subtype Return_Code_Type is Interfaces.C.Int;

    subtype Display_Type is System.Address;
    type GC_Type is new System.Address;

    subtype Xid_Type is Interfaces.C.Unsigned_Long;
    subtype Window_Type is Xid_Type;
    subtype Atom_Type is Xid_Type;
    subtype Time_Type is Xid_Type;
    subtype Drawable_Type is Xid_Type;
    subtype Colormap_Type is Xid_Type;
    subtype Cursor_Type is Xid_Type;
    subtype VisualId_Type is Xid_Type;

    CurrentTime : constant Time_Type := 0;

    function Open_Display (Name : Interfaces.C.Strings.Chars_Ptr) return Display_Type;
    pragma Import (C, Open_Display, "XOpenDisplay");

    function Default_Root_Window (D : Display_Type) return Window_Type;
    pragma Import (C, Default_Root_Window, "XDefaultRootWindow");

    function Grab_Button (Display : Display_Type;
                          Button  : Unsigned;
                          Modifiers : Unsigned;
                          Grab_Window  : Window_Type;
                          Owner_Events : Int;
                          Event_Mask   : Unsigned;
                          Pointer_Mode : Int;
                          Keyboard_Mode : Int;
                          Confine_To   : Window_Type;
                          Cursor       : Cursor_Type) return Return_Code_Type;
    pragma Import (C, Grab_Button, "XGrabButton");

    function Grab_Pointer (Display : Display_Type;
                           Grab_Window : Window_Type;
                           Owner_Events : Int;
                           Event_Mask   : Unsigned;
                           Pointer_Mode : Int;
                           Keyboard_Mode : Int;
                           Confine_To    : Window_Type;
                           Cursor        : Cursor_Type;
                           Time          : Time_Type) return Return_Code_Type;
    pragma Import (C, Grab_Pointer, "XGrabPointer");

    function Ungrab_Pointer (Display : Display_Type;
                             Time    : Time_Type) return Return_Code_Type;
   pragma Import (C, Ungrab_Pointer, "XUngrabPointer");

    type XPointer is new Interfaces.C.Strings.Chars_Ptr;
    type u_XExtData is record
        number : aliased Int;
        next : access u_XExtData;
        free_private : access function (arg1 : access u_XExtData) return int;
        private_data : XPointer;
    end record;
    pragma Convention (C_Pass_By_Copy, u_XExtData);
    subtype XExtData is u_XExtData;

    type Visual_Type is record
        ext_data : access XExtData;
        the_visualid : aliased VisualId_Type;
        class : aliased Int;
        red_mask : aliased Unsigned_Long;
        green_mask : aliased Unsigned_Long;
        blue_mask : aliased Unsigned_Long;
        bits_per_rgb : aliased Int;
        map_entries : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, Visual_Type);

    type Depth_Type is record
        depth : aliased Int;
        nvisuals : aliased Int;
        visuals : access Visual_Type;
    end record;
    pragma Convention (C_Pass_By_Copy, Depth_Type);

    type Screen_Type is record
        ext_data : access XExtData;
        display : Display_Type;
        root : aliased Window_Type;
        width : aliased Int;
        height : aliased Int;
        mwidth : aliased Int;
        mheight : aliased Int;
        ndepths : aliased Int;
        depths : access Depth_Type;
        root_depth : aliased Int;
        root_visual : access Visual_Type;
        default_gc : GC_Type;
        cmap : aliased Colormap_Type;
        white_pixel : aliased Unsigned_Long;
        black_pixel : aliased Unsigned_Long;
        max_maps : aliased Int;
        min_maps : aliased Int;
        backing_store : aliased Int;
        save_unders : aliased Int;
        root_input_mask : aliased Long;
    end record;
    pragma Convention (C_Pass_By_Copy, Screen_Type);

    type Window_Attributes_Type is record
        x : aliased Int;
        y : aliased Int;
        width : aliased Int;
        height : aliased Int;
        border_width : aliased Int;
        depth : aliased Int;
        the_visual : access Visual_Type;
        root : aliased Window_Type;
        class : aliased Int;
        bit_gravity : aliased Int;
        win_gravity : aliased Int;
        backing_store : aliased Int;
        backing_planes : aliased Unsigned_Long;
        backing_pixel : aliased Unsigned_Long;
        save_under : aliased Int;
        the_colormap : aliased Colormap_Type;
        map_installed : aliased Int;
        map_state : aliased Int;
        all_event_masks : aliased Long;
        your_event_mask : aliased Long;
        do_not_propagate_mask : aliased Long;
        override_redirect : aliased Int;
        the_screen : access Screen_Type;
    end record;
    pragma Convention (C_Pass_By_Copy, Window_Attributes_Type);

    function Get_Window_Attributes (Display : Display_Type;
                                    Window : Window_Type;
                                    Attributes : access Window_Attributes_Type) return Return_Code_Type;
    pragma Import (C, Get_Window_Attributes, "XGetWindowAttributes");
end Xlib;
