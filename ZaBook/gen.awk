{
	aa = $1; bb = $2; cc = $3;
	if ( aa > 119 && aa < 230 )
	{
#		printf(" %s_%s_%s\n",aa,bb,cc);
		printf("if [ $1 -eq %s ]; then\n",$1);
		print "vid=$1";
		printf("vcname=\"%s\"\n",bb);
		printf("vename=\"%s\"\n",cc);
		print "fi"; 
	}
#	
}