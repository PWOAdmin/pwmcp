with PW_Config;
use PW_Config;
with GNATCOLL.JSON;
with Ada.Containers.Vectors;
package Mcp_Tool is

type Tool_Property_Type is record
Property_Name: Mcp_String;
Property_Description: Mcp_String;
Property_Type: Mcp_String;
Is_Required: Boolean;
end record;



 function "=" (Left, Right : Tool_Property_Type) return Boolean;
 package  Schema is new Ada.Containers.Vectors(Positive, Tool_Property_Type, "=");
 


Type Mcp_Tool_Type is abstract tagged record
Name: Mcp_String;
Description: Mcp_String;
Input_Schema: Schema.Vector;
Output_Schema: Schema.Vector;
Payload: GNATCOLL.JSON.JSON_Value;
end record;

 function "=" (Left, Right : Mcp_Tool_Type) return Boolean;

 procedure Setup (Tool: in out Mcp_Tool_Type) is abstract;

 function Execute (Tool: in out Mcp_Tool_Type) return GNATCOLL.JSON.JsON_Value is abstract;

 function Property_JSON (Prop: Tool_Property_Type) return GNATCOLL.JSON.Json_Value;
 function Schema_JSON (S: Schema.Vector) return GNATCOLL.JSON.JSON_Value;

 function Tool_JSON (Tool: Mcp_Tool_Type'Class) return GNATCOLL.JSON.JSON_Value;


end Mcp_Tool;