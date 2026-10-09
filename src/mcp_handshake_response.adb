with GNATCOLL.JSON;
with Mcp_Response;
with PW_Config;
use GNATCOLL;
package body Mcp_Handshake_Response is

function To_JSON (Response: Handhake_Response_Type) return JSON.JSON_Value
is
use PW_Config;
package R renames MCP_Record_Fields;
Handshake_Response: JSON.JSON_Value:=Mcp_Response.To_JSON(Response.Parent);
Result: JSON.JSON_Value:=JSON.Create_Object;
Capabilities_Json: JSON.JSON_Value:=JSON.Create_Object;
Tools_Json: JSON.JSON_Value:=JSON.Create_Object;
Server_Info_Json: JSON.JSON_Value:=JSON.Create_Object;
begin

if Response.Capabiliities.Has_Logging = true then
Capabilities_Json.Set_Field("logging", JSON.Create_Object);
end if;

 Tools_Json.Set_Field ("listChanged", Response.Capabiliities.List_Changed);
 Capabilities_Json.Set_Field("tools", Tools_Json);

declare
Server_Name: constant String:=R.To_String(response.Server_Info.Server_Name);
Server_Title: constant String:=R.To_String(Response.Server_Info.Server_Title);
Server_Version: constant String:= R.To_String(Response.Server_Info.Server_Version);
begin
Server_Info_Json.Set_Field("name", Server_Name);
Server_Info_Json.Set_Field("title", Server_Title);
Server_Info_Json.Set_Field("version", Server_Version);
end;


Result.Set_Field("capabilities", Capabilities_Json);
Result.Set_Field("serverInfo", Server_Info_Json);
Result.Set_Field("protocolVersion", PW_Config.MCP_PROTOCOL_VERSION);
Handshake_Response.Set_Field("result", Result);
return Handshake_Response;
end To_JSON;


end Mcp_Handshake_Response;