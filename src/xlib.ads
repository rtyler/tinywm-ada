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

    subtype Return_Code_Type is Interfaces.C.Int;
    subtype Display_Type is System.Address;
    subtype Xid_Type is Interfaces.C.Unsigned_Long;
    subtype Window_Type is Xid_Type;
    subtype Atom_Type is Xid_Type;
    subtype Time_Type is Xid_Type;
    subtype Drawable_Type is Xid_Type;
    subtype Colormap_Type is Xid_Type;

    function Open_Display (Name : Interfaces.C.Strings.Chars_Ptr) return Display_Type;
    pragma Import (C, Open_Display, "XOpenDisplay");

    function Default_Root_Window (D : Display_Type) return Window_Type;
    pragma Import (C, Default_Root_Window, "XDefaultRootWindow");


    type XKeyEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:566
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:567
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:568
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:569
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:570
        root : aliased Window_Type;  -- /usr/include/X11/Xlib.h:571
        subwindow : aliased Window_Type;  -- /usr/include/X11/Xlib.h:572
        the_time : aliased Time_Type;  -- /usr/include/X11/Xlib.h:573
        x : aliased Int;  -- /usr/include/X11/Xlib.h:574
        y : aliased Int;  -- /usr/include/X11/Xlib.h:574
        x_root : aliased Int;  -- /usr/include/X11/Xlib.h:575
        y_root : aliased Int;  -- /usr/include/X11/Xlib.h:575
        state : aliased Unsigned;  -- /usr/include/X11/Xlib.h:576
        keycode : aliased Unsigned;  -- /usr/include/X11/Xlib.h:577
        same_screen : aliased Int;  -- /usr/include/X11/Xlib.h:578
    end record;
    pragma Convention (C_Pass_By_Copy, XKeyEvent);  -- /usr/include/X11/Xlib.h:579

    subtype XKeyPressedEvent is XKeyEvent;  -- /usr/include/X11/Xlib.h:580

    subtype XKeyReleasedEvent is XKeyEvent;  -- /usr/include/X11/Xlib.h:581

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
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:584
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:585
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:586
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:587
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:588
        root : aliased Window_Type;  -- /usr/include/X11/Xlib.h:589
        subwindow : aliased Window_Type;  -- /usr/include/X11/Xlib.h:590
        the_time : aliased Time_Type;  -- /usr/include/X11/Xlib.h:591
        x : aliased Int;  -- /usr/include/X11/Xlib.h:592
        y : aliased Int;  -- /usr/include/X11/Xlib.h:592
        x_root : aliased Int;  -- /usr/include/X11/Xlib.h:593
        y_root : aliased Int;  -- /usr/include/X11/Xlib.h:593
        state : aliased Unsigned;  -- /usr/include/X11/Xlib.h:594
        button : aliased Unsigned;  -- /usr/include/X11/Xlib.h:595
        same_screen : aliased Int;  -- /usr/include/X11/Xlib.h:596
    end record;
    pragma Convention (C_Pass_By_Copy, XButtonEvent);  -- /usr/include/X11/Xlib.h:597

    subtype XButtonPressedEvent is XButtonEvent;  -- /usr/include/X11/Xlib.h:598

    subtype XButtonReleasedEvent is XButtonEvent;  -- /usr/include/X11/Xlib.h:599

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
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:602
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:603
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:604
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:605
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:606
        root : aliased Window_Type;  -- /usr/include/X11/Xlib.h:607
        subwindow : aliased Window_Type;  -- /usr/include/X11/Xlib.h:608
        the_time : aliased Time_Type;  -- /usr/include/X11/Xlib.h:609
        x : aliased Int;  -- /usr/include/X11/Xlib.h:610
        y : aliased Int;  -- /usr/include/X11/Xlib.h:610
        x_root : aliased Int;  -- /usr/include/X11/Xlib.h:611
        y_root : aliased Int;  -- /usr/include/X11/Xlib.h:611
        state : aliased Unsigned;  -- /usr/include/X11/Xlib.h:612
        is_hint : aliased char;  -- /usr/include/X11/Xlib.h:613
        same_screen : aliased Int;  -- /usr/include/X11/Xlib.h:614
    end record;
    pragma Convention (C_Pass_By_Copy, XMotionEvent);  -- /usr/include/X11/Xlib.h:615

    subtype XPointerMovedEvent is XMotionEvent;  -- /usr/include/X11/Xlib.h:616

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
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:619
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:620
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:621
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:622
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:623
        root : aliased Window_Type;  -- /usr/include/X11/Xlib.h:624
        subwindow : aliased Window_Type;  -- /usr/include/X11/Xlib.h:625
        the_time : aliased Time_Type;  -- /usr/include/X11/Xlib.h:626
        x : aliased Int;  -- /usr/include/X11/Xlib.h:627
        y : aliased Int;  -- /usr/include/X11/Xlib.h:627
        x_root : aliased Int;  -- /usr/include/X11/Xlib.h:628
        y_root : aliased Int;  -- /usr/include/X11/Xlib.h:628
        mode : aliased Int;  -- /usr/include/X11/Xlib.h:629
        detail : aliased Int;  -- /usr/include/X11/Xlib.h:630
        same_screen : aliased Int;  -- /usr/include/X11/Xlib.h:635
        focus : aliased Int;  -- /usr/include/X11/Xlib.h:636
        state : aliased Unsigned;  -- /usr/include/X11/Xlib.h:637
    end record;
    pragma Convention (C_Pass_By_Copy, XCrossingEvent);  -- /usr/include/X11/Xlib.h:638

    subtype XEnterWindowEvent is XCrossingEvent;  -- /usr/include/X11/Xlib.h:639

    subtype XLeaveWindowEvent is XCrossingEvent;  -- /usr/include/X11/Xlib.h:640

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
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:643
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:644
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:645
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:646
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:647
        mode : aliased Int;  -- /usr/include/X11/Xlib.h:648
        detail : aliased Int;  -- /usr/include/X11/Xlib.h:650
    end record;
    pragma Convention (C_Pass_By_Copy, XFocusChangeEvent);  -- /usr/include/X11/Xlib.h:656

    subtype XFocusInEvent is XFocusChangeEvent;  -- /usr/include/X11/Xlib.h:657

    subtype XFocusOutEvent is XFocusChangeEvent;  -- /usr/include/X11/Xlib.h:658

    -- generated on EnterWindow and FocusIn  when KeyMapState selected  
    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    subtype XKeymapEvent_key_vector_array is Interfaces.C.char_array (0 .. 31);
    type XKeymapEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:662
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:663
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:664
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:665
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:666
        key_vector : aliased XKeymapEvent_key_vector_array;  -- /usr/include/X11/Xlib.h:667
    end record;
    pragma Convention (C_Pass_By_Copy, XKeymapEvent);  -- /usr/include/X11/Xlib.h:668

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- if non-zero, at least this many more  
    type XExposeEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:671
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:672
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:673
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:674
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:675
        x : aliased Int;  -- /usr/include/X11/Xlib.h:676
        y : aliased Int;  -- /usr/include/X11/Xlib.h:676
        width : aliased Int;  -- /usr/include/X11/Xlib.h:677
        height : aliased Int;  -- /usr/include/X11/Xlib.h:677
        count : aliased Int;  -- /usr/include/X11/Xlib.h:678
    end record;
    pragma Convention (C_Pass_By_Copy, XExposeEvent);  -- /usr/include/X11/Xlib.h:679

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- if non-zero, at least this many more  
    -- core is CopyArea or CopyPlane  
    -- not defined in the core  
    type XGraphicsExposeEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:682
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:683
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:684
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:685
        the_drawable : aliased Drawable_Type;  -- /usr/include/X11/Xlib.h:686
        x : aliased Int;  -- /usr/include/X11/Xlib.h:687
        y : aliased Int;  -- /usr/include/X11/Xlib.h:687
        width : aliased Int;  -- /usr/include/X11/Xlib.h:688
        height : aliased Int;  -- /usr/include/X11/Xlib.h:688
        count : aliased Int;  -- /usr/include/X11/Xlib.h:689
        major_code : aliased Int;  -- /usr/include/X11/Xlib.h:690
        minor_code : aliased Int;  -- /usr/include/X11/Xlib.h:691
    end record;
    pragma Convention (C_Pass_By_Copy, XGraphicsExposeEvent);  -- /usr/include/X11/Xlib.h:692

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- core is CopyArea or CopyPlane  
    -- not defined in the core  
    type XNoExposeEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:695
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:696
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:697
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:698
        the_drawable : aliased Drawable_Type;  -- /usr/include/X11/Xlib.h:699
        major_code : aliased Int;  -- /usr/include/X11/Xlib.h:700
        minor_code : aliased Int;  -- /usr/include/X11/Xlib.h:701
    end record;
    pragma Convention (C_Pass_By_Copy, XNoExposeEvent);  -- /usr/include/X11/Xlib.h:702

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- Visibility state  
    type XVisibilityEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:705
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:706
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:707
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:708
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:709
        state : aliased Int;  -- /usr/include/X11/Xlib.h:710
    end record;
    pragma Convention (C_Pass_By_Copy, XVisibilityEvent);  -- /usr/include/X11/Xlib.h:711

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
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:714
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:715
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:716
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:717
        parent : aliased Window_Type;  -- /usr/include/X11/Xlib.h:718
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:719
        x : aliased Int;  -- /usr/include/X11/Xlib.h:720
        y : aliased Int;  -- /usr/include/X11/Xlib.h:720
        width : aliased Int;  -- /usr/include/X11/Xlib.h:721
        height : aliased Int;  -- /usr/include/X11/Xlib.h:721
        border_width : aliased Int;  -- /usr/include/X11/Xlib.h:722
        override_redirect : aliased Int;  -- /usr/include/X11/Xlib.h:723
    end record;
    pragma Convention (C_Pass_By_Copy, XCreateWindowEvent);  -- /usr/include/X11/Xlib.h:724

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XDestroyWindowEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:727
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:728
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:729
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:730
        event : aliased Window_Type;  -- /usr/include/X11/Xlib.h:731
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:732
    end record;
    pragma Convention (C_Pass_By_Copy, XDestroyWindowEvent);  -- /usr/include/X11/Xlib.h:733

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XUnmapEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:736
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:737
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:738
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:739
        event : aliased Window_Type;  -- /usr/include/X11/Xlib.h:740
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:741
        from_configure : aliased Int;  -- /usr/include/X11/Xlib.h:742
    end record;
    pragma Convention (C_Pass_By_Copy, XUnmapEvent);  -- /usr/include/X11/Xlib.h:743

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- boolean, is override set...  
    type XMapEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:746
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:747
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:748
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:749
        event : aliased Window_Type;  -- /usr/include/X11/Xlib.h:750
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:751
        override_redirect : aliased Int;  -- /usr/include/X11/Xlib.h:752
    end record;
    pragma Convention (C_Pass_By_Copy, XMapEvent);  -- /usr/include/X11/Xlib.h:753

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XMapRequestEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:756
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:757
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:758
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:759
        parent : aliased Window_Type;  -- /usr/include/X11/Xlib.h:760
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:761
    end record;
    pragma Convention (C_Pass_By_Copy, XMapRequestEvent);  -- /usr/include/X11/Xlib.h:762

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XReparentEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:765
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:766
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:767
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:768
        event : aliased Window_Type;  -- /usr/include/X11/Xlib.h:769
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:770
        parent : aliased Window_Type;  -- /usr/include/X11/Xlib.h:771
        x : aliased Int;  -- /usr/include/X11/Xlib.h:772
        y : aliased Int;  -- /usr/include/X11/Xlib.h:772
        override_redirect : aliased Int;  -- /usr/include/X11/Xlib.h:773
    end record;
    pragma Convention (C_Pass_By_Copy, XReparentEvent);  -- /usr/include/X11/Xlib.h:774

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XConfigureEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:777
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:778
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:779
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:780
        event : aliased Window_Type;  -- /usr/include/X11/Xlib.h:781
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:782
        x : aliased Int;  -- /usr/include/X11/Xlib.h:783
        y : aliased Int;  -- /usr/include/X11/Xlib.h:783
        width : aliased Int;  -- /usr/include/X11/Xlib.h:784
        height : aliased Int;  -- /usr/include/X11/Xlib.h:784
        border_width : aliased Int;  -- /usr/include/X11/Xlib.h:785
        above : aliased Window_Type;  -- /usr/include/X11/Xlib.h:786
        override_redirect : aliased Int;  -- /usr/include/X11/Xlib.h:787
    end record;
    pragma Convention (C_Pass_By_Copy, XConfigureEvent);  -- /usr/include/X11/Xlib.h:788

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XGravityEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:791
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:792
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:793
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:794
        event : aliased Window_Type;  -- /usr/include/X11/Xlib.h:795
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:796
        x : aliased Int;  -- /usr/include/X11/Xlib.h:797
        y : aliased Int;  -- /usr/include/X11/Xlib.h:797
    end record;
    pragma Convention (C_Pass_By_Copy, XGravityEvent);  -- /usr/include/X11/Xlib.h:798

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XResizeRequestEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:801
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:802
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:803
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:804
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:805
        width : aliased Int;  -- /usr/include/X11/Xlib.h:806
        height : aliased Int;  -- /usr/include/X11/Xlib.h:806
    end record;
    pragma Convention (C_Pass_By_Copy, XResizeRequestEvent);  -- /usr/include/X11/Xlib.h:807

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- Above, Below, TopIf, BottomIf, Opposite  
    type XConfigureRequestEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:810
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:811
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:812
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:813
        parent : aliased Window_Type;  -- /usr/include/X11/Xlib.h:814
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:815
        x : aliased Int;  -- /usr/include/X11/Xlib.h:816
        y : aliased Int;  -- /usr/include/X11/Xlib.h:816
        width : aliased Int;  -- /usr/include/X11/Xlib.h:817
        height : aliased Int;  -- /usr/include/X11/Xlib.h:817
        border_width : aliased Int;  -- /usr/include/X11/Xlib.h:818
        above : aliased Window_Type;  -- /usr/include/X11/Xlib.h:819
        detail : aliased Int;  -- /usr/include/X11/Xlib.h:820
        value_mask : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:821
    end record;
    pragma Convention (C_Pass_By_Copy, XConfigureRequestEvent);  -- /usr/include/X11/Xlib.h:822

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- PlaceOnTop, PlaceOnBottom  
    type XCirculateEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:825
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:826
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:827
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:828
        event : aliased Window_Type;  -- /usr/include/X11/Xlib.h:829
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:830
        place : aliased Int;  -- /usr/include/X11/Xlib.h:831
    end record;
    pragma Convention (C_Pass_By_Copy, XCirculateEvent);  -- /usr/include/X11/Xlib.h:832

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- PlaceOnTop, PlaceOnBottom  
    type XCirculateRequestEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:835
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:836
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:837
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:838
        parent : aliased Window_Type;  -- /usr/include/X11/Xlib.h:839
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:840
        place : aliased Int;  -- /usr/include/X11/Xlib.h:841
    end record;
    pragma Convention (C_Pass_By_Copy, XCirculateRequestEvent);  -- /usr/include/X11/Xlib.h:842

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- NewValue, Deleted  
    type XPropertyEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:845
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:846
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:847
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:848
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:849
        the_atom : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:850
        the_time : aliased Time_Type;  -- /usr/include/X11/Xlib.h:851
        state : aliased Int;  -- /usr/include/X11/Xlib.h:852
    end record;
    pragma Convention (C_Pass_By_Copy, XPropertyEvent);  -- /usr/include/X11/Xlib.h:853

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XSelectionClearEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:856
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:857
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:858
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:859
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:860
        selection : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:861
        the_time : aliased Time_Type;  -- /usr/include/X11/Xlib.h:862
    end record;
    pragma Convention (C_Pass_By_Copy, XSelectionClearEvent);  -- /usr/include/X11/Xlib.h:863

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    type XSelectionRequestEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:866
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:867
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:868
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:869
        owner : aliased Window_Type;  -- /usr/include/X11/Xlib.h:870
        requestor : aliased Window_Type;  -- /usr/include/X11/Xlib.h:871
        selection : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:872
        target : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:873
        property : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:874
        the_time : aliased Time_Type;  -- /usr/include/X11/Xlib.h:875
    end record;
    pragma Convention (C_Pass_By_Copy, XSelectionRequestEvent);  -- /usr/include/X11/Xlib.h:876

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- ATOM or None  
    type XSelectionEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:879
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:880
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:881
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:882
        requestor : aliased Window_Type;  -- /usr/include/X11/Xlib.h:883
        selection : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:884
        target : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:885
        property : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:886
        the_time : aliased Time_Type;  -- /usr/include/X11/Xlib.h:887
    end record;
    pragma Convention (C_Pass_By_Copy, XSelectionEvent);  -- /usr/include/X11/Xlib.h:888

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- COLORMAP or None  
    -- C++  
    -- ColormapInstalled, ColormapUninstalled  
    type XColormapEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:891
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:892
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:893
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:894
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:895
        the_colormap : aliased Colormap_Type;  -- /usr/include/X11/Xlib.h:896
        c_new : aliased Int;  -- /usr/include/X11/Xlib.h:900
        state : aliased Int;  -- /usr/include/X11/Xlib.h:902
    end record;
    pragma Convention (C_Pass_By_Copy, XColormapEvent);  -- /usr/include/X11/Xlib.h:903

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    subtype anon1303_anon1305_array is Interfaces.C.char_array (0 .. 19);
    type anon1303_anon1307_array is array (0 .. 9) of aliased short;
    type anon1303_anon1309_array is array (0 .. 4) of aliased long;
    type anon_1303 (discr : unsigned := 0) is record
        case discr is
            when 0 =>
            b : aliased anon1303_anon1305_array;  -- /usr/include/X11/Xlib.h:914
            when 1 =>
            s : aliased anon1303_anon1307_array;  -- /usr/include/X11/Xlib.h:915
            when others =>
            l : aliased anon1303_anon1309_array;  -- /usr/include/X11/Xlib.h:916
        end case;
    end record;
    pragma Convention (C_Pass_By_Copy, anon_1303);
    pragma Unchecked_Union (anon_1303);  -- /usr/include/X11/Xlib.h:913

    subtype XClientMessageEvent_b_array is Interfaces.C.char_array (0 .. 19);
    type XClientMessageEvent_s_array is array (0 .. 9) of aliased short;
    type XClientMessageEvent_l_array is array (0 .. 4) of aliased long;
    type XClientMessageEvent_data_union (discr : unsigned := 0) is record
        case discr is
            when 0 =>
            b : aliased XClientMessageEvent_b_array;  -- /usr/include/X11/Xlib.h:914
            when 1 =>
            s : aliased XClientMessageEvent_s_array;  -- /usr/include/X11/Xlib.h:915
            when others =>
            l : aliased XClientMessageEvent_l_array;  -- /usr/include/X11/Xlib.h:916
        end case;
    end record;
    pragma Convention (C_Pass_By_Copy, XClientMessageEvent_data_union);
    pragma Unchecked_Union (XClientMessageEvent_data_union);
    type XClientMessageEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:906
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:907
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:908
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:909
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:910
        message_type : aliased Atom_Type;  -- /usr/include/X11/Xlib.h:911
        format : aliased Int;  -- /usr/include/X11/Xlib.h:912
        data : XClientMessageEvent_data_union;  -- /usr/include/X11/Xlib.h:917
    end record;
    pragma Convention (C_Pass_By_Copy, XClientMessageEvent);  -- /usr/include/X11/Xlib.h:918

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- unused  
    -- one of MappingModifier, MappingKeyboard,
    --				   MappingPointer  

    -- first keycode  
    -- defines range of change w. first_keycode 
    type XMappingEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:921
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:922
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:923
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:924
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:925
        request : aliased Int;  -- /usr/include/X11/Xlib.h:926
        first_keycode : aliased Int;  -- /usr/include/X11/Xlib.h:928
        count : aliased Int;  -- /usr/include/X11/Xlib.h:929
    end record;
    pragma Convention (C_Pass_By_Copy, XMappingEvent);  -- /usr/include/X11/Xlib.h:930

    -- Display the event was read from  
    -- resource id  
    -- serial number of failed request  
    -- error code of failed request  
    -- Major op-code of failed request  
    -- Minor op-code of failed request  
    type XErrorEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:933
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:934
        resourceid : aliased Xid_Type;  -- /usr/include/X11/Xlib.h:935
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:936
        error_code : aliased Unsigned_char;  -- /usr/include/X11/Xlib.h:937
        request_code : aliased Unsigned_char;  -- /usr/include/X11/Xlib.h:938
        minor_code : aliased Unsigned_char;  -- /usr/include/X11/Xlib.h:939
    end record;
    pragma Convention (C_Pass_By_Copy, XErrorEvent);  -- /usr/include/X11/Xlib.h:940

    -- # of last request processed by server  
    -- true if this came from a SendEvent request  
    -- Display the event was read from  
    -- window on which event was requested in event mask  
    type XAnyEvent is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:943
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:944
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:945
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:946
        the_window : aliased Window_Type;  -- /usr/include/X11/Xlib.h:947
    end record;
    pragma Convention (C_Pass_By_Copy, XAnyEvent);  -- /usr/include/X11/Xlib.h:948

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
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:958
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:959
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:960
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:961
        extension : aliased Int;  -- /usr/include/X11/Xlib.h:962
        evtype : aliased Int;  -- /usr/include/X11/Xlib.h:963
    end record;
    pragma Convention (C_Pass_By_Copy, XGenericEvent);  -- /usr/include/X11/Xlib.h:964

    -- of event. Always GenericEvent  
    -- # of last request processed  
    -- true if from SendEvent request  
    -- Display the event was read from  
    -- major opcode of extension that caused the event  
    -- actual event type.  
    type XGenericEventCookie is record
        c_type : aliased Int;  -- /usr/include/X11/Xlib.h:967
        serial : aliased Unsigned_Long;  -- /usr/include/X11/Xlib.h:968
        send_event : aliased Int;  -- /usr/include/X11/Xlib.h:969
        the_display : System.Address;  -- /usr/include/X11/Xlib.h:970
        extension : aliased Int;  -- /usr/include/X11/Xlib.h:971
        evtype : aliased Int;  -- /usr/include/X11/Xlib.h:972
        cookie : aliased Unsigned;  -- /usr/include/X11/Xlib.h:973
        data : System.Address;  -- /usr/include/X11/Xlib.h:974
    end record;
    pragma Convention (C_Pass_By_Copy, XGenericEventCookie);  -- /usr/include/X11/Xlib.h:975

    -- * this union is defined so Xlib can always use the same sized
    -- * event structure internally, to avoid memory fragmentation.
    --  

    -- must not be changed; first element  
    type anon1321_anon1323_array is array (0 .. 23) of aliased long;
    type u_XEvent (discr : unsigned := 0) is record
        case discr is
            when 0 =>
            c_type : aliased Int;  -- /usr/include/X11/Xlib.h:982
            when 1 =>
            xany : aliased XAnyEvent;  -- /usr/include/X11/Xlib.h:983
            when 2 =>
            xkey : aliased XKeyEvent;  -- /usr/include/X11/Xlib.h:984
            when 3 =>
            xbutton : aliased XButtonEvent;  -- /usr/include/X11/Xlib.h:985
            when 4 =>
            xmotion : aliased XMotionEvent;  -- /usr/include/X11/Xlib.h:986
            when 5 =>
            xcrossing : aliased XCrossingEvent;  -- /usr/include/X11/Xlib.h:987
            when 6 =>
            xfocus : aliased XFocusChangeEvent;  -- /usr/include/X11/Xlib.h:988
            when 7 =>
            xexpose : aliased XExposeEvent;  -- /usr/include/X11/Xlib.h:989
            when 8 =>
            xgraphicsexpose : aliased XGraphicsExposeEvent;  -- /usr/include/X11/Xlib.h:990
            when 9 =>
            xnoexpose : aliased XNoExposeEvent;  -- /usr/include/X11/Xlib.h:991
            when 10 =>
            xvisibility : aliased XVisibilityEvent;  -- /usr/include/X11/Xlib.h:992
            when 11 =>
            xcreatewindow : aliased XCreateWindowEvent;  -- /usr/include/X11/Xlib.h:993
            when 12 =>
            xdestroywindow : aliased XDestroyWindowEvent;  -- /usr/include/X11/Xlib.h:994
            when 13 =>
            xunmap : aliased XUnmapEvent;  -- /usr/include/X11/Xlib.h:995
            when 14 =>
            xmap : aliased XMapEvent;  -- /usr/include/X11/Xlib.h:996
            when 15 =>
            xmaprequest : aliased XMapRequestEvent;  -- /usr/include/X11/Xlib.h:997
            when 16 =>
            xreparent : aliased XReparentEvent;  -- /usr/include/X11/Xlib.h:998
            when 17 =>
            xconfigure : aliased XConfigureEvent;  -- /usr/include/X11/Xlib.h:999
            when 18 =>
            xgravity : aliased XGravityEvent;  -- /usr/include/X11/Xlib.h:1000
            when 19 =>
            xresizerequest : aliased XResizeRequestEvent;  -- /usr/include/X11/Xlib.h:1001
            when 20 =>
            xconfigurerequest : aliased XConfigureRequestEvent;  -- /usr/include/X11/Xlib.h:1002
            when 21 =>
            xcirculate : aliased XCirculateEvent;  -- /usr/include/X11/Xlib.h:1003
            when 22 =>
            xcirculaterequest : aliased XCirculateRequestEvent;  -- /usr/include/X11/Xlib.h:1004
            when 23 =>
            xproperty : aliased XPropertyEvent;  -- /usr/include/X11/Xlib.h:1005
            when 24 =>
            xselectionclear : aliased XSelectionClearEvent;  -- /usr/include/X11/Xlib.h:1006
            when 25 =>
            xselectionrequest : aliased XSelectionRequestEvent;  -- /usr/include/X11/Xlib.h:1007
            when 26 =>
            xselection : aliased XSelectionEvent;  -- /usr/include/X11/Xlib.h:1008
            when 27 =>
            xcolormap : aliased XColormapEvent;  -- /usr/include/X11/Xlib.h:1009
            when 28 =>
            xclient : aliased XClientMessageEvent;  -- /usr/include/X11/Xlib.h:1010
            when 29 =>
            xmapping : aliased XMappingEvent;  -- /usr/include/X11/Xlib.h:1011
            when 30 =>
            xerror : aliased XErrorEvent;  -- /usr/include/X11/Xlib.h:1012
            when 31 =>
            xkeymap : aliased XKeymapEvent;  -- /usr/include/X11/Xlib.h:1013
            when 32 =>
            xgeneric : aliased XGenericEvent;  -- /usr/include/X11/Xlib.h:1014
            when 33 =>
            xcookie : aliased XGenericEventCookie;  -- /usr/include/X11/Xlib.h:1015
            when others =>
            pad : aliased anon1321_anon1323_array;  -- /usr/include/X11/Xlib.h:1016
        end case;
    end record;
    pragma Convention (C_Pass_By_Copy, u_XEvent);
    pragma Unchecked_Union (u_XEvent);  -- /usr/include/X11/Xlib.h:981
    subtype XEvent is u_XEvent;

    type Event_Ptr is access XEvent;

    function Next_Event (D : Display_Type; Event : Event_Ptr) return Return_Code_Type;
    pragma Import (C, Next_Event, "XNextEvent");
end Xlib;
