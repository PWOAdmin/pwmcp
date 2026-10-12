with GNATCOLL.JSON;
with Mcp_Handshake_Response;
with Mcp_Tools_Registry;
with Mcp_Tool;
with PW_Config;
with Mcp_Exceptions;
use Mcp_Exceptions;
package body PWMcp is
use GNATCOLL;
package R renames PW_Config.MCP_Record_Fields;

function On_Initialize(Handshake: Mcp_Handshake_Response.Handhake_Response_Type) return String
is

begin
return JSON.Write (Mcp_Handshake_Response.To_JSON (Handshake));
end On_Initialize;

function On_Tools_Call (Input_Js: JSON.JSON_Value) return String 
is
function Get_Tool_By_Name (Tool_Name: String) return Mcp_Tool.Mcp_Tool_Type'Class
is

begin
   for Tool of Mcp_Tools_Registry.Registry loop
      if R.To_String(Tool.Name) = Tool_Name then
         return Tool;
         end if;
   end Loop;
   raise Tool_Not_Found_Exception;
end Get_Tool_By_Name;
Params: JSON.JSON_Value:=JSON.Get (Input_Js, "params");
Tool_Name: constant String:=JSON.Get(Params, "name");
ATool: Mcp_Tool.Mcp_Tool_Type'class:=Get_Tool_By_Name (Tool_Name);
begin
ATool.Payload:=Params;
return JSON.Write (Atool.Execute);

end On_Tools_Call;

function Parse_Payload (Input_Json: in String; Handshake: Mcp_Handshake_Response.Handhake_Response_Type) return String 
is
Input_JS: JSON.JSON_Value:=JSON.Read(Input_Json);
Result: JSON.JSON_Value:=JSON.Create_Object;
Id: Integer;
begin

if JSON.Has_Field (Input_JS, "id") then
Id:=JSON.Get (Input_JS, "id");
end if;

if JSON.Has_Field (Input_JS, "method") then
declare
Method: constant String:=JSON.Get (Input_JS, "method");
begin
   if Method = "initialize" then 
   declare 
      HS_Copy: Mcp_Handshake_Response.Handhake_Response_Type:=Handshake;
      begin
    HS_Copy.Parent.Id:=Id;
   return On_Initialize(HS_Copy);
   end; 
   end if;
   If Method = "tools/list" then return JSON.Write (Mcp_Tools_Registry.Create_Tools_JSON_Response(Id)); end if;
   If Method = "tools/call" then return On_Tools_Call (Input_JS); end if;
end;

end if;

return JSON.Write (Result);
end Parse_Payload;





end PWMcp;