--  Main driver for the tinywm example
--


with Ada.Command_Line,
     Ada.Text_IO,
     System,
     Xlib;

procedure TinyWM is
    package CLI renames Ada.Command_Line;
    use Ada.Text_IO,
        System;

    Display : Xlib.Display_Type;
    Window : Xlib.Window_Type;
    Event : Xlib.Event_Ptr;
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

    while true loop
        declare
            Code : Xlib.Return_Code_Type;
        begin
            Code := Xlib.Next_Event (Display, Event);
            Put_Line ("Received an event (code: " &
                        Xlib.Return_Code_Type'Image (Code) &
                        ")");
        end;
    end loop;

end TinyWM;
