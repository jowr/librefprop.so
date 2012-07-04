within MediaTwoPhaseMixture.REFPROPMedium;
function setState_pqX "Calculates medium properties from p,q,X"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.MassFraction q "quality (vapor mass fraction)";
  input Modelica.SIunits.MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
//  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_pqX("+String(p)+","+String(q)+",X)...");
  end if;
  state := setState("pq",p,q,X,phase) ",fluidnames)";
end setState_pqX;
