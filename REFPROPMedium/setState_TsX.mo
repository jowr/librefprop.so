within MediaTwoPhaseMixture.REFPROPMedium;
function setState_TsX "Calculates medium properties from T,s,X"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input SpecificEntropy s "Entropy";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
//  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_TsX("+String(T)+","+String(s)+",X)...");
  end if;
  state := setState("Ts",T,s,X,phase) ",fluidnames)";
end setState_TsX;
