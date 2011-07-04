--  Main driver for the tinywm example
--


with Ada.Command_Line,
     Ada.Text_IO,
     System,
     Xlib,
     Xlib.Keys;

procedure TinyWM is
    package CLI renames Ada.Command_Line;
    use Ada.Text_IO,
        System;

    Display : Xlib.Display_Type;
    Window : Xlib.Window_Type;
    Event : aliased Xlib.XEvent;
    Code : Xlib.Return_Code_Type;
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


    Window := Xlib.Default_Root_Window (Display);

    -- Set up the move button key combo (Alt + LeftMouseClick)
    Code := Xlib.Grab_Button (Display => Display,
                              Button => 1,
                              Modifiers => Xlib.Keys.Mod1Mask,
                              Grab_Window => Window,
                              Owner_Events => Xlib.True,
                              Event_Mask => Xlib.ButtonPressMask,
                              Pointer_Mode => Xlib.GrabModeAsync,
                              Keyboard_Mode => Xlib.GrabModeAsync,
                              Confine_To => Xlib.Window_Type (Xlib.Null_Atom),
                              Cursor => Xlib.Cursor_Type (Xlib.Null_Atom));

    -- Set up the resize key combo (Alt + RightMouseClick)
    Code := Xlib.Grab_Button (Display => Display,
                              Button => 3,
                              Modifiers => Xlib.Keys.Mod1Mask,
                              Grab_Window => Window,
                              Owner_Events => Xlib.True,
                              Event_Mask => Xlib.ButtonPressMask,
                              Pointer_Mode => Xlib.GrabModeAsync,
                              Keyboard_Mode => Xlib.GrabModeAsync,
                              Confine_To => Xlib.Window_Type (Xlib.Null_Atom),
                              Cursor => Xlib.Cursor_Type (Xlib.Null_Atom));

    while true loop
        Code := Xlib.Next_Event (Display, Event'Unchecked_Access);
        Put_Line ("Received an event (code: " &
                    Xlib.Return_Code_Type'Image (Code) &
                    ")");
    end loop;

end TinyWM;
