.global func_s

func_s:
	flds f;
	flds g;		// met g a s[0] et f est a s[1]
	fsubrp;		// f-g est dans s[0] et s[1]
	fstps a;	// met f-g a l'adresse de a

	flds b;
	flds d;		//s[0] contient d et s[1] contient b
	fmulp;		// b*d est dans s[0] et s[1]
	flds c;		// s[0] contient c et s[1] contient b*d
	fsubrp;		// (b*d)-c est dans s[0] et s[1]

	flds a;		// met (f-g) sur s[0]
	fdivrp;		// ( (b*d)-c ) / (f-g) met le resultat dans s[0] et s[1]
	flds e;
	faddp;		// s[0] et s[1] contient tout le memmbre de droite
	fstps a;	// met le membre de droite a l'adresse de a


	flds g;
	flds e;		//s[0] contient e, g est dans s[1]
	fsubrp;		//s[0] et s[1] contiennet g-e
	flds f;		//s[0] contient f, s[1] contient g-e
	fdivrp;		//s[0] et s[1] contiennent le membre de droite
	
	flds a;		// s[0] membre de droite et s[1] membre de gauche
	fmulp;		// multiplie le membre de droite et celui de gauche
	fstps a;	

	ret
