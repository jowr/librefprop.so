within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function setState_pdX "Calculates medium properties from p,d,X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Density d "Density";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
//  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_pdX("+String(p)+","+String(d)+",X)...");
  end if;
  state := setState("pd",p,d,X,phase) ",fluidnames)";
end setState_pdX;
