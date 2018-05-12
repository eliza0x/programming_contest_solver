main = do
    long long  N,countm=0,counta=0,countr=0,countc=0,counth=0;
    long long ans=0;
    
    string people;
 
 
    cin>>N;
 
    for(int i=0;i<N;i++){
        cin>> people;
        if(people[0]=='M')countm++;
        if(people[0]=='A')counta++;
        if(people[0]=='R')countr++;
        if(people[0]=='C')countc++;
        if(people[0]=='H')counth++;
    }
 
 
    ans=countm*counta*countr+countm*counta*countc+countm*counta*counth+countm*countr*countc+countm*countr*counth+countm*countc*counth+counta*countr*countc+counta*countr*counth+counta*countc*counth+countr*countc*counth;
 
    cout<<ans<<endl;
 
}
