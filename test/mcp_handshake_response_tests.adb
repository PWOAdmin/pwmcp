with AUnit.Assertions;
with AUnit.Test_Caller;
with GNATCOLL.JSON;
with Mcp_Handshake_Response;
with PW_Config;

with Ada.Text_IO;
use Ada.Text_IO;

package body Mcp_Handshake_Response_Tests is
   package JSON renames GNATCOLL.JSON;
   package Caller is new AUnit.Test_Caller (Test_Fixture);

   function Make_Response
     (Has_Logging : Boolean;
      List_Changed : Boolean)
      return Mcp_Handshake_Response.Handhake_Response_Type
   is
      Response : Mcp_Handshake_Response.Handhake_Response_Type;
   begin
      Response.Id := 73;
      Response.Parent.Id := 73;
      Response.Server_Info.Server_Name :=
        PW_Config.MCP_Record_Fields.To_Bounded_String ("PWMCP");
      Response.Server_Info.Server_Title :=
        PW_Config.MCP_Record_Fields.To_Bounded_String ("Power Manager");
      Response.Server_Info.Server_Version :=
        PW_Config.MCP_Record_Fields.To_Bounded_String ("1.2.3");
      Response.Capabiliities.Has_Logging := Has_Logging;
      Response.Capabiliities.List_Changed := List_Changed;
      return Response;
   end Make_Response;

   procedure Test_Serializes_Handshake (Test : in out Test_Fixture) is
      pragma Unreferenced (Test);
      Document : constant JSON.JSON_Value :=
        Mcp_Handshake_Response.To_JSON (Make_Response (True, True));
      Result : constant JSON.JSON_Value := JSON.Get (Document, "result");
      Capabilities : constant JSON.JSON_Value :=
        JSON.Get (Result, "capabilities");
      Tools : constant JSON.JSON_Value := JSON.Get (Capabilities, "tools");
      Server_Info : constant JSON.JSON_Value :=
        JSON.Get (Result, "serverInfo");
   begin
   Put_Line(Document.write);
      AUnit.Assertions.Assert
        (String'(JSON.Get (Document, "jsonrpc")) = PW_Config.JSONRPC_VERSION,
         "JSON-RPC version should be serialized");
      AUnit.Assertions.Assert
        (Integer'(JSON.Get (Document, "id")) = 73,
         "Response id should be serialized");
      AUnit.Assertions.Assert
        (String'(JSON.Get (Result, "protocolVersion")) =
           PW_Config.MCP_PROTOCOL_VERSION,
         "Protocol version should be serialized");
      AUnit.Assertions.Assert
        (JSON.Has_Field (Capabilities, "logging"),
         "Logging capability should be present when enabled");
      AUnit.Assertions.Assert
        (JSON.Get (Tools, "listChanged"),
         "Tools listChanged capability should be true");
      AUnit.Assertions.Assert
        (String'(JSON.Get (Server_Info, "name")) = "PWMCP",
         "Server name should be serialized");
      AUnit.Assertions.Assert
        (String'(JSON.Get (Server_Info, "title")) = "Power Manager",
         "Server title should be serialized");
      AUnit.Assertions.Assert
        (String'(JSON.Get (Server_Info, "version")) = "1.2.3",
         "Server version should be serialized");
   end Test_Serializes_Handshake;

   procedure Test_Omits_Disabled_Logging (Test : in out Test_Fixture) is
      pragma Unreferenced (Test);
      Document : constant JSON.JSON_Value :=
        Mcp_Handshake_Response.To_JSON (Make_Response (False, False));
      Capabilities : constant JSON.JSON_Value :=
        JSON.Get (JSON.Get (Document, "result"), "capabilities");
      Tools : constant JSON.JSON_Value := JSON.Get (Capabilities, "tools");
   begin
      AUnit.Assertions.Assert
        (not JSON.Has_Field (Capabilities, "logging"),
         "Logging capability should be omitted when disabled");
      AUnit.Assertions.Assert
        (not JSON.Get (Tools, "listChanged"),
         "Tools listChanged capability should be false");
   end Test_Omits_Disabled_Logging;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test
        (Caller.Create
           ("Serialize handshake response",
            Test_Serializes_Handshake'Access));
      Result.Add_Test
        (Caller.Create
           ("Omit disabled logging capability",
            Test_Omits_Disabled_Logging'Access));
      return Result;
   end Suite;
end Mcp_Handshake_Response_Tests;