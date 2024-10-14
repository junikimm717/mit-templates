add_cus_dep("asy","eps",0,"asy2eps");
add_cus_dep("asy","pdf",0,"asy2pdf");
add_cus_dep("asy","tex",0,"asy2tex");

sub asy2eps { return asy2x( $_[0], 'eps' ); }
sub asy2pdf { return asy2x( $_[0], 'pdf' ); }
sub asy2tex { return asy2x( $_[0], 'tex' ); }

sub asy2x   {
   my $ret = system("asy -vv -f '$_[1]' '$_[0]' >& '$_[0].log'");
   open( my $FH, "<", "$_[0].log" );
   %imp = ();

   while (<$FH>) {
       if (/^(Including|Loading) .* from (.*)\s*$/) {
          my $import = $2;
	  $imp{$import} = 1;
       }
       elsif ( /^error/ || /^.*\.asy: \d/ ) {
           warn "==Message from asy: $_";
	   $ret = 1;
       }
       elsif ( /^kpsewhich / || /^Processing / || /^Using /
               || /^Welcome / || /^Wrote /|| /^cd /|| /^gs /
	     ) {
       }
       else {
           warn "==Message from asy: $_";
       }
   }
   close $FH;
# For latexmk 4.48
   rdb_set_source( $rule, keys %imp );
   return $ret;
}

$pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode';
$pdf_mode = 1;        # tex -> pdf
@default_files = ('main.tex');
