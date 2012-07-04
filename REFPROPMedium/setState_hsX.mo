within MediaTwoPhaseMixture.REFPROPMedium;
function setState_hsX "Calculates medium properties from h,s,X"
  extends Modelica.Icons.Function;
  input SpecificEnthalpy h "Enthalpy";
  input SpecificEntropy s "Entropy";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
//  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running ("+String(h)+","+String(s)+",X)...");
  end if;
  state := setState("hs",h,s,X,phase) ",fluidnames)";
end setState_hsX;
