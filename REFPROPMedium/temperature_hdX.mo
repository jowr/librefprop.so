within MediaTwoPhaseMixture.REFPROPMedium;
function temperature_hdX "calls REFPROP-Wrapper, returns temperature"
extends Modelica.Icons.Function;
    input Modelica.SIunits.SpecificEnthalpy h;
    input Modelica.SIunits.Density d;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Temperature T;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running temperature_hdX("+String(h)+","+String(d)+",X)");
  end if;
  T :=getProp_REFPROP_check("T", "hd",h,d,X,phase);
  annotation(LateInline=true,inverse(d=density_ThX(T,h,X,phase),
                                     h=specificEnthalpy_dTX(d,T,X,phase)));
end temperature_hdX;
