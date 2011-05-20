within MediaTwoPhaseMixture.REFPROPMedium;
function setState_ThX "Calculates medium properties from T,h,X"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input SpecificEnthalpy h "Enthalpy";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_ThX("+String(T)+","+String(h)+",X)...");
  end if;
  state := setState("Th",T,h,X,phase,fluidnames);
end setState_ThX;
