with Mcp_Tool;
with Ada.Containers.Indefinite_Vectors;
use Ada.Containers;
package Mcp_Tools_Registry is

package Mcp_Tool_Vector is new Indefinite_Vectors(Index_Type => Positive,
Element_Type => Mcp_Tool.Mcp_Tool_Type'class, "=" => Mcp_Tool."=");

--Procedure Register_Tool (Reg: in out Registry_Type; Tool: Mcp_Tool.Mcp_Tool_Type);



Registry: Mcp_Tool_Vector.Vector;



end Mcp_Tools_Registry;