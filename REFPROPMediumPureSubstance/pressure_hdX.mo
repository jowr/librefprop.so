within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function pressure_hdX "calls REFPROP-Wrapper, returns pressure"
extends Modelica.Icons.Function;
    input Modelica.SIunits.SpecificEnthalpy h;
    input Modelica.SIunits.Density d;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Pressure p;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running pressure_hdX("+String(h)+","+String(d)+",X)");
  end if;
    p :=getProp_REFPROP_check("p", "hd", fluidnames,h,d,X,phase);
  annotation(LateInline=true,inverse(d=density_phX(p,h,X,phase),
                                     h=specificEnthalpy_pdX(p,d,X,phase)));
end pressure_hdX;
