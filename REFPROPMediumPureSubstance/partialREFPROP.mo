within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
partial function partialREFPROP "Declaration of array props"
//used by getSatProp_REFPROP_check() and getProp_REFPROP_check()
  extends Modelica.Icons.Function;
protected
   Real[16+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",64),"")
    "Allocating memory, string will be written by C function, doesn't work for strings longer than 40 bytes";
end partialREFPROP;
