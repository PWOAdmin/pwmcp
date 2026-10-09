with Ada.Command_Line;
with AUnit;
with AUnit.Reporter.Text;
with AUnit.Run;
with Mcp_Handshake_Response_Tests;

procedure Test_Driver is
   use type AUnit.Status;

   Reporter : AUnit.Reporter.Text.Text_Reporter;
   function Run_Tests is new AUnit.Run.Test_Runner_With_Status
     (Mcp_Handshake_Response_Tests.Suite);
begin
   if Run_Tests (Reporter) /= AUnit.Success then
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;
end Test_Driver;