with Mcp_Handshake_Response;
package PWMcp is
   
function Parse_Payload (Input_Json: in String; Handshake: in out Mcp_Handshake_Response.Handhake_Response_Type) return String;

end PWMcp;
