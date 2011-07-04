--  Main driver for the tinywm example
--


with Ada.Command_Line,
     Ada.Text_IO,
     Interfaces.C,
     System,
     Xlib,
     Xlib.Event,
     Xlib.Masks,
     Xlib.Keys;

procedure TinyWM is
    package CLI renames Ada.Command_Line;
    use Ada.Text_IO,
        Interfaces.C,
        System;

    Display : Xlib.Display_Type;
    Root : Xlib.Window_Type;
    -- We'll use this to hold onto the pointer's state at the beginning of a move/resize
    Start : Xlib.Event.XButtonEvent;
    Attributes : aliased Xlib.Window_Attributes_Type;
    Event : aliased Xlib.Event.XEvent;
    Code : Xlib.Return_Code_Type;

    function Max (A : in Int; B : in Int) return Int is
    begin
        if A > B then
            return A;
        end if;
        return B;
    end Max;
begin
    Put_Line ("Starting TinyWM");

    Display := Xlib.Open_Display (Xlib.Null_Display);

    if Display = Null_Address then
        Put_Line ("Failed to properly open the display!");
        CLI.Set_Exit_Status (1);
        return;
    else
        Put_Line ("Opened a connection to the display");
    end if;


    Root := Xlib.Default_Root_Window (Display);

    -- Set up the move button key combo (Alt + LeftMouseClick)
    Code := Xlib.Grab_Button (Display => Display,
                              Button => 1,
                              Modifiers => Xlib.Keys.Mod4Mask,
                              Grab_Window => Root,
                              Owner_Events => Xlib.True,
                              Event_Mask => Xlib.Masks.ButtonPressMask,
                              Pointer_Mode => Xlib.GrabModeAsync,
                              Keyboard_Mode => Xlib.GrabModeAsync,
                              Confine_To => Xlib.Window_Type (Xlib.Null_Atom),
                              Cursor => Xlib.Cursor_Type (Xlib.Null_Atom));

    -- Set up the resize key combo (Alt + RightMouseClick)
    Code := Xlib.Grab_Button (Display => Display,
                              Button => 3,
                              Modifiers => Xlib.Keys.Mod4Mask,
                              Grab_Window => Root,
                              Owner_Events => Xlib.True,
                              Event_Mask => Xlib.Masks.ButtonPressMask,
                              Pointer_Mode => Xlib.GrabModeAsync,
                              Keyboard_Mode => Xlib.GrabModeAsync,
                              Confine_To => Xlib.Window_Type (Xlib.Null_Atom),
                              Cursor => Xlib.Cursor_Type (Xlib.Null_Atom));

    while true loop
        Code := Xlib.Event.Next_Event (Display, Event'Unchecked_Access);

        case Event.C_Type is
            when Xlib.Event.ButtonPress =>
                Put_Line ("Button Pressed!");
                Code := Xlib.Grab_Pointer (Display => Display,
                                        Grab_Window => Event.XButton.Subwindow,
                                        Owner_Events => Xlib.True,
                                        Event_Mask => Xlib.Masks.PointerMotionMask or Xlib.Masks.ButtonReleaseMask,
                                        Pointer_Mode => Xlib.GrabModeAsync,
                                        Keyboard_Mode => Xlib.GrabModeAsync,
                                        Confine_To => Xlib.Window_Type (Xlib.Null_Atom),
                                        Cursor => Xlib.Cursor_Type (Xlib.Null_Atom),
                                        Time => Xlib.CurrentTime);

                -- Remember the position of the pointer at the beginning of the
                -- move/resize and the size/position of the window. That means we
                -- can properly move/resize as the pointer moves
                Code := Xlib.Get_Window_Attributes (Display => Display,
                                                    Window => Event.XButton.Subwindow,
                                                    Attributes => Attributes'Access);
                Start := Event.XButton;

            when Xlib.Event.ButtonRelease =>
                Put_Line ("Button released");
                Code := Xlib.Ungrab_Pointer (Display => Display,
                                             Time => Xlib.CurrentTime);

            when Xlib.Event.MotionNotify =>
                Code := 1;
                while Code > 0 loop
                    Code := Xlib.Event.Check_Typed_Event (Display => Display,
                                                          Event_Mask => Xlib.Event.MotionNotify,
                                                          Event => Event'Unchecked_Access);
                    declare
                        X_Diff : Int := Event.XButton.X_Root - Start.X_Root;
                        Y_Diff : Int := Event.XButton.Y_Root - Start.Y_Root;
                        X : Int := Attributes.X;
                        Y : Int := Attributes.Y;
                        Width : Int := Attributes.Width;
                        Height : Int := Attributes.Height;
                        Move_Code : Xlib.Return_Code_Type;
                    begin
                        if Start.Button = 1 then
                            X := Attributes.X + X_Diff;
                            Y := Attributes.Y + Y_Diff;
                        else
                            Width := Max (1, Attributes.Width + X_Diff);
                            Height := Max (1, Attributes.Height + Y_Diff);
                        end if;

                        Move_Code := Xlib.Move_Resize_Window (Display => Display,
                                                              Window => Event.XMotion.The_Window,
                                                              X => X,
                                                              Y => Y,
                                                              Width => Unsigned (Width),
                                                              Height => Unsigned (Height));
                    end;
                end loop;

            when others =>
                Put_Line ("Received an unhandled event (code: " &
                            Xlib.Return_Code_Type'Image (Code) &
                            ")");
        end case;
    end loop;

end TinyWM;
