with Ada.Strings.Bounded;
package PW_Config is

-- Max length of each MCP Record String field
MAX_FIELD_LENGTH: constant Positive:=512;
JSONRPC_VERSION : constant String:="2.0";
MCP_PROTOCOL_VERSION: constant String:="2025-11-25";
 

package MCP_Record_Fields is new Ada.Strings.Bounded.Generic_Bounded_Length(Max=>MAX_FIELD_LENGTH);
subtype Mcp_String is MCP_Record_Fields.Bounded_String;



end PW_Config;