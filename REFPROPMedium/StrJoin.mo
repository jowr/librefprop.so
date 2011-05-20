within MediaTwoPhaseMixture.REFPROPMedium;
function StrJoin "Converts an Array of Strings into a string separated by |"
  input String[:] s_in;
  input String delimiter;
  output String s_out;
algorithm
  s_out :=s_in[1];
  for i in 2:size(s_in,1) loop
    s_out :=s_out + delimiter + s_in[i];
  end for;
end StrJoin;
