s = [ "ab"; "cde" ];
all(all(strcat (s, s, s) == ["ab ab ab " ; "cdecdecde" ]))
