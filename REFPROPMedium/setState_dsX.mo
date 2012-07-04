within MediaTwoPhaseMixture.REFPROPMedium;
function setState_dsX "Calculates medium properties from d,s,X"
  extends Modelica.Icons.Function;
  input Density d "Temperature";
  input SpecificEntropy s "Entropy";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
//  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_dsX("+String(d)+","+String(s)+",X)...");
  end if;
  state := setState("ds",d,s,X,phase) ",fluidnames)";
end setState_dsX;
