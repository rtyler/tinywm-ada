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
    ButtonPressMask : constant Interfaces.C.Unsigned := (2**2);
    ButtonReleaseMask : constant Interfaces.C.Unsigned := (2**3);

    subtype Return_Code_Type is Interfaces.C.Int;
    subtype Display_Type is System.Address;
    subtype Xid_Type is Interfaces.C.Unsigned_Long;
    subtype Window_Type is Xid_Type;
    subtype Atom_Type is Xid_Type;
    subtype Time_Type is Xid_Type;
    subtype Drawable_Type is Xid_Type;
    subtype Colormap_Type is Xid_Type;
    subtype Cursor_Type is Xid_Type;

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

    type XKeyEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        root : aliased Window_Type;
        subwindow : aliased Window_Type;
        the_time : aliased Time_Type;
        x : aliased Int;
        y : aliased Int;
        x_root : aliased Int;
        y_root : aliased Int;
        state : aliased Unsigned;
        keycode : aliased Unsigned;
        same_screen : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XKeyEvent);

    subtype XKeyPressedEvent is XKeyEvent;

    subtype XKeyReleasedEvent is XKeyEvent;

    -- of event  
    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- "event" window it is reported relative to  
    -- root window that the event occurred on  
    -- child window  
    -- milliseconds  
    -- pointer x, y coordinates in event window  
    -- coordinates relative to root  
    -- key or button mask  
    -- detail  
    -- same screen flag  
    type XButtonEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        root : aliased Window_Type;
        subwindow : aliased Window_Type;
        the_time : aliased Time_Type;
        x : aliased Int;
        y : aliased Int;
        x_root : aliased Int;
        y_root : aliased Int;
        state : aliased Unsigned;
        button : aliased Unsigned;
        same_screen : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XButtonEvent);

    subtype XButtonPressedEvent is XButtonEvent;

    subtype XButtonReleasedEvent is XButtonEvent;

    -- of event  
    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- "event" window reported relative to  
    -- root window that the event occurred on  
    -- child window  
    -- milliseconds  
    -- pointer x, y coordinates in event window  
    -- coordinates relative to root  
    -- key or button mask  
    -- detail  
    -- same screen flag  
    type XMotionEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        root : aliased Window_Type;
        subwindow : aliased Window_Type;
        the_time : aliased Time_Type;
        x : aliased Int;
        y : aliased Int;
        x_root : aliased Int;
        y_root : aliased Int;
        state : aliased Unsigned;
        is_hint : aliased Char;
        same_screen : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XMotionEvent);

    subtype XPointerMovedEvent is XMotionEvent;

    -- of event  
    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- "event" window reported relative to  
    -- root window that the event occurred on  
    -- child window  
    -- milliseconds  
    -- pointer x, y coordinates in event window  
    -- coordinates relative to root  
    -- NotifyNormal, NotifyGrab, NotifyUngrab  
    --	 * NotifyAncestor, NotifyVirtual, NotifyInferior,
    --	 * NotifyNonlinear,NotifyNonlinearVirtual
    --	  

    -- same screen flag  
    -- boolean focus  
    -- key or button mask  
    type XCrossingEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        root : aliased Window_Type;
        subwindow : aliased Window_Type;
        the_time : aliased Time_Type;
        x : aliased Int;
        y : aliased Int;
        x_root : aliased Int;
        y_root : aliased Int;
        mode : aliased Int;
        detail : aliased Int;
        same_screen : aliased Int;
        focus : aliased Int;
        state : aliased Unsigned;
    end record;
    pragma Convention (C_Pass_By_Copy, XCrossingEvent);

    subtype XEnterWindowEvent is XCrossingEvent;

    subtype XLeaveWindowEvent is XCrossingEvent;

    -- FocusIn or FocusOut  
    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- window of event  
    -- NotifyNormal, NotifyWhileGrabbed,
    --				   NotifyGrab, NotifyUngrab  

    --	 * NotifyAncestor, NotifyVirtual, NotifyInferior,
    --	 * NotifyNonlinear,NotifyNonlinearVirtual, NotifyPointer,
    --	 * NotifyPointerRoot, NotifyDetailNone
    --	  

    type XFocusChangeEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        mode : aliased Int;
        detail : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XFocusChangeEvent);

    subtype XFocusInEvent is XFocusChangeEvent;

    subtype XFocusOutEvent is XFocusChangeEvent;

    -- generated on EnterWindow and FocusIn  when KeyMapState selected  
    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    subtype XKeymapEvent_key_vector_array is Interfaces.C.char_array (0 .. 31);
    type XKeymapEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        key_vector : aliased XKeymapEvent_key_vector_array;
    end record;
    pragma Convention (C_Pass_By_Copy, XKeymapEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- if non-zero, at least this many more  
    type XExposeEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        x : aliased Int;
        y : aliased Int;
        width : aliased Int;
        height : aliased Int;
        count : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XExposeEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- if non-zero, at least this many more  
    -- core is CopyArea or CopyPlane  
    -- not defined in the core  
    type XGraphicsExposeEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_drawable : aliased Drawable_Type;
        x : aliased Int;
        y : aliased Int;
        width : aliased Int;
        height : aliased Int;
        count : aliased Int;
        major_code : aliased Int;
        minor_code : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XGraphicsExposeEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- core is CopyArea or CopyPlane  
    -- not defined in the core  
    type XNoExposeEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_drawable : aliased Drawable_Type;
        major_code : aliased Int;
        minor_code : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XNoExposeEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- Visibility state  
    type XVisibilityEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        state : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XVisibilityEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- parent of the window  
    -- window id of window created  
    -- window location  
    -- size of window  
    -- border width  
    -- creation should be overridden  
    type XCreateWindowEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        parent : aliased Window_Type;
        the_window : aliased Window_Type;
        x : aliased Int;
        y : aliased Int;
        width : aliased Int;
        height : aliased Int;
        border_width : aliased Int;
        override_redirect : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XCreateWindowEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XDestroyWindowEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        event : aliased Window_Type;
        the_window : aliased Window_Type;
    end record;
    pragma Convention (C_Pass_By_Copy, XDestroyWindowEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XUnmapEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        event : aliased Window_Type;
        the_window : aliased Window_Type;
        from_configure : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XUnmapEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- boolean, is override set...  
    type XMapEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        event : aliased Window_Type;
        the_window : aliased Window_Type;
        override_redirect : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XMapEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XMapRequestEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        parent : aliased Window_Type;
        the_window : aliased Window_Type;
    end record;
    pragma Convention (C_Pass_By_Copy, XMapRequestEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XReparentEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        event : aliased Window_Type;
        the_window : aliased Window_Type;
        parent : aliased Window_Type;
        x : aliased Int;
        y : aliased Int;
        override_redirect : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XReparentEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XConfigureEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        event : aliased Window_Type;
        the_window : aliased Window_Type;
        x : aliased Int;
        y : aliased Int;
        width : aliased Int;
        height : aliased Int;
        border_width : aliased Int;
        above : aliased Window_Type;
        override_redirect : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XConfigureEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XGravityEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        event : aliased Window_Type;
        the_window : aliased Window_Type;
        x : aliased Int;
        y : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XGravityEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XResizeRequestEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        width : aliased Int;
        height : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XResizeRequestEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- Above, Below, TopIf, BottomIf, Opposite  
    type XConfigureRequestEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        parent : aliased Window_Type;
        the_window : aliased Window_Type;
        x : aliased Int;
        y : aliased Int;
        width : aliased Int;
        height : aliased Int;
        border_width : aliased Int;
        above : aliased Window_Type;
        detail : aliased Int;
        value_mask : aliased Unsigned_Long;
    end record;
    pragma Convention (C_Pass_By_Copy, XConfigureRequestEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- PlaceOnTop, PlaceOnBottom  
    type XCirculateEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        event : aliased Window_Type;
        the_window : aliased Window_Type;
        place : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XCirculateEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- PlaceOnTop, PlaceOnBottom  
    type XCirculateRequestEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        parent : aliased Window_Type;
        the_window : aliased Window_Type;
        place : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XCirculateRequestEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- NewValue, Deleted  
    type XPropertyEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        the_atom : aliased Atom_Type;
        the_time : aliased Time_Type;
        state : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XPropertyEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XSelectionClearEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        selection : aliased Atom_Type;
        the_time : aliased Time_Type;
    end record;
    pragma Convention (C_Pass_By_Copy, XSelectionClearEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XSelectionRequestEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        owner : aliased Window_Type;
        requestor : aliased Window_Type;
        selection : aliased Atom_Type;
        target : aliased Atom_Type;
        property : aliased Atom_Type;
        the_time : aliased Time_Type;
    end record;
    pragma Convention (C_Pass_By_Copy, XSelectionRequestEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- ATOM or None  
    type XSelectionEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        requestor : aliased Window_Type;
        selection : aliased Atom_Type;
        target : aliased Atom_Type;
        property : aliased Atom_Type;
        the_time : aliased Time_Type;
    end record;
    pragma Convention (C_Pass_By_Copy, XSelectionEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- COLORMAP or None  
    -- C++  
    -- ColormapInstalled, ColormapUninstalled  
    type XColormapEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        the_colormap : aliased Colormap_Type;
        c_new : aliased Int;
        state : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XColormapEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    subtype anon1303_anon1305_array is Interfaces.C.char_array (0 .. 19);
    type anon1303_anon1307_array is array (0 .. 9) of aliased short;
    type anon1303_anon1309_array is array (0 .. 4) of aliased long;
    type anon_1303 (discr : unsigned := 0) is record
        case discr is
            when 0 =>
            b : aliased anon1303_anon1305_array;
            when 1 =>
            s : aliased anon1303_anon1307_array;
            when others =>
            l : aliased anon1303_anon1309_array;
        end case;
    end record;
    pragma Convention (C_Pass_By_Copy, anon_1303);
    pragma Unchecked_Union (anon_1303);

    subtype XClientMessageEvent_b_array is Interfaces.C.char_array (0 .. 19);
    type XClientMessageEvent_s_array is array (0 .. 9) of aliased short;
    type XClientMessageEvent_l_array is array (0 .. 4) of aliased long;
    type XClientMessageEvent_data_union (discr : unsigned := 0) is record
        case discr is
            when 0 =>
            b : aliased XClientMessageEvent_b_array;
            when 1 =>
            s : aliased XClientMessageEvent_s_array;
            when others =>
            l : aliased XClientMessageEvent_l_array;
        end case;
    end record;
    pragma Convention (C_Pass_By_Copy, XClientMessageEvent_data_union);
    pragma Unchecked_Union (XClientMessageEvent_data_union);
    type XClientMessageEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        message_type : aliased Atom_Type;
        format : aliased Int;
        data : XClientMessageEvent_data_union;
    end record;
    pragma Convention (C_Pass_By_Copy, XClientMessageEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- unused  
    -- one of MappingModifier, MappingKeyboard,
    --				   MappingPointer  

    -- first keycode  
    -- defines range of change w. first_keycode 
    type XMappingEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
        request : aliased Int;
        first_keycode : aliased Int;
        count : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XMappingEvent);

    -- Display the event was read from  
    -- resource id  
    -- serial number of failed request  
    -- error code of failed request  
    -- Major op-code of failed request  
    -- Minor op-code of failed request  
    type XErrorEvent is record
        c_type : aliased Int;
        the_display : System.Address;
        resourceid : aliased Xid_Type;
        serial : aliased Unsigned_Long;
        error_code : aliased Unsigned_char;
        request_code : aliased Unsigned_char;
        minor_code : aliased Unsigned_char;
    end record;
    pragma Convention (C_Pass_By_Copy, XErrorEvent);

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- window on which event was requested in event mask  
    type XAnyEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        the_window : aliased Window_Type;
    end record;
    pragma Convention (C_Pass_By_Copy, XAnyEvent);

    --**************************************************************
    -- *
    -- * GenericEvent.  This event is the standard event for all newer extensions.
    --  

    -- of event. Always GenericEvent  
    -- # of last request processed  
    -- true if from SendEvent request  
    -- Display the event was read from  
    -- major opcode of extension that caused the event  
    -- actual event type.  
    type XGenericEvent is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        extension : aliased Int;
        evtype : aliased Int;
    end record;
    pragma Convention (C_Pass_By_Copy, XGenericEvent);

    -- of event. Always GenericEvent  
    -- # of last request processed  
    -- true if from SendEvent request  
    -- Display the event was read from  
    -- major opcode of extension that caused the event  
    -- actual event type.  
    type XGenericEventCookie is record
        c_type : aliased Int;
        serial : aliased Unsigned_Long;
        send_event : aliased Int;
        the_display : System.Address;
        extension : aliased Int;
        evtype : aliased Int;
        cookie : aliased Unsigned;
        data : System.Address;
    end record;
    pragma Convention (C_Pass_By_Copy, XGenericEventCookie);

    -- * this union is defined so Xlib can always use the same sized
    -- * event structure internally, to avoid memory fragmentation.
    --  

    type XEvent_Padding is array (0 .. 23) of aliased Long;
    type u_XEvent (discr : unsigned := 0) is record
        case discr is
            when 0 =>
            c_type : aliased Int;
            when 1 =>
            xany : aliased XAnyEvent;
            when 2 =>
            xkey : aliased XKeyEvent;
            when 3 =>
            xbutton : aliased XButtonEvent;
            when 4 =>
            xmotion : aliased XMotionEvent;
            when 5 =>
            xcrossing : aliased XCrossingEvent;
            when 6 =>
            xfocus : aliased XFocusChangeEvent;
            when 7 =>
            xexpose : aliased XExposeEvent;
            when 8 =>
            xgraphicsexpose : aliased XGraphicsExposeEvent;
            when 9 =>
            xnoexpose : aliased XNoExposeEvent;
            when 10 =>
            xvisibility : aliased XVisibilityEvent;
            when 11 =>
            xcreatewindow : aliased XCreateWindowEvent;
            when 12 =>
            xdestroywindow : aliased XDestroyWindowEvent;
            when 13 =>
            xunmap : aliased XUnmapEvent;
            when 14 =>
            xmap : aliased XMapEvent;
            when 15 =>
            xmaprequest : aliased XMapRequestEvent;
            when 16 =>
            xreparent : aliased XReparentEvent;
            when 17 =>
            xconfigure : aliased XConfigureEvent;
            when 18 =>
            xgravity : aliased XGravityEvent;
            when 19 =>
            xresizerequest : aliased XResizeRequestEvent;
            when 20 =>
            xconfigurerequest : aliased XConfigureRequestEvent;
            when 21 =>
            xcirculate : aliased XCirculateEvent;
            when 22 =>
            xcirculaterequest : aliased XCirculateRequestEvent;
            when 23 =>
            xproperty : aliased XPropertyEvent;
            when 24 =>
            xselectionclear : aliased XSelectionClearEvent;
            when 25 =>
            xselectionrequest : aliased XSelectionRequestEvent;
            when 26 =>
            xselection : aliased XSelectionEvent;
            when 27 =>
            xcolormap : aliased XColormapEvent;
            when 28 =>
            xclient : aliased XClientMessageEvent;
            when 29 =>
            xmapping : aliased XMappingEvent;
            when 30 =>
            xerror : aliased XErrorEvent;
            when 31 =>
            xkeymap : aliased XKeymapEvent;
            when 32 =>
            xgeneric : aliased XGenericEvent;
            when 33 =>
            xcookie : aliased XGenericEventCookie;
            when others =>
            pad : aliased XEvent_Padding;
        end case;
    end record;
    pragma Convention (C_Pass_By_Copy, u_XEvent);
    pragma Unchecked_Union (u_XEvent);
    subtype XEvent is u_XEvent;

    type Event_Ptr is access all XEvent;

    function Next_Event (D : Display_Type; Event : Event_Ptr) return Return_Code_Type;
    pragma Import (C, Next_Event, "XNextEvent");
end Xlib;
