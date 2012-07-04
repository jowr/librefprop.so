within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function specificEntropy_phX
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.SpecificEnthalpy h;
  input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
//  input String fluidnames;
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEntropy s;
/*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Running specificEntropy_phX("+String(p)+","+String(h)+",X)...");
    // p="+String(p)+",h="+String(h)+", X={"+String(X[1])+","+String(X[2])+"}");
    end if;
    s:=getProp_REFPROP_check("s", "ph",p,h,X,phase);
  annotation(LateInline=true,inverse(h=specificEnthalpy_psX(p,s,X,phase),
                                     p=pressure_hsX(h,s,X,phase)));
end specificEntropy_phX;
