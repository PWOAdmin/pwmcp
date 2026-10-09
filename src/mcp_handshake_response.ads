with PW_Config;
with Mcp_Response;
with GNATCOLL.JSON;

package Mcp_Handshake_Response is
use PW_Config;

Type Capabilities_Type is record
Has_Logging: boolean:=true;
List_Changed: Boolean:=true;
end record;

Type Server_Info_Type is record
   Server_Name: Mcp_String;
   Server_Title: Mcp_String;
   Server_Version: Mcp_String;
end Record;

type Handhake_Response_Type is new Mcp_Response.Mcp_Response_Type with record
Parent: Mcp_Response.Mcp_Response_Type;
Server_Info: Server_Info_Type;
Capabiliities: Capabilities_Type;

end record;

function To_JSON (Response: Handhake_Response_Type) return GNATCOLL.JSON.JSON_Value;

end Mcp_Handshake_Response;