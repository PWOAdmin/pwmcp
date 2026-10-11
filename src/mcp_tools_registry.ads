with Mcp_Tool;
use Mcp_Tool;
with Ada.Containers.Indefinite_Vectors;
with Gnatcoll.JSON;
use Ada.Containers;

package Mcp_Tools_Registry is

package Mcp_Tool_Vector is new Indefinite_Vectors(Index_Type => Natural,
Element_Type => Mcp_Tool_Type'class);

Procedure Register_Tool (Tool: Mcp_Tool_Type'Class);

function Create_Tools_JSON_Response (Id: Integer) return GNATCOLL.JSON.JSON_Value;


Registry: Mcp_Tool_Vector.Vector;



end Mcp_Tools_Registry;