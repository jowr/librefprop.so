within MediaTwoPhaseMixture.REFPROPMedium;
function setState_hdX "Calculates medium properties from h,d,X"
  extends Modelica.Icons.Function;
  input SpecificEnthalpy h "Enthalpy";
  input Density d "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
//  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_hdX("+String(h)+","+String(d)+",X)...");
  end if;
  state := setState("hd",h,d,X,phase) ",fluidnames)";
end setState_hdX;
