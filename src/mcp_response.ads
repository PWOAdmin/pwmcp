with PW_Config;
use PW_Config;
with GNATCOLL.JSON;
package Mcp_Response is


Type Mcp_Response_Type is tagged record
Id: Integer;

end record;

function To_JSON (Response: Mcp_Response_Type'class) return GNATCOLL.JSON.JSON_Value;

end Mcp_Response;