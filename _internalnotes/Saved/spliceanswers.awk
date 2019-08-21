{ \
    if ($0 == "---") {
        getline; \
        while (!match($0, "---")) { \
            split( $0, fields, ":" );
            if ( (fields[1] == "title") || (fields[1] == "permalink") || (fields[1] == "category") || (fields[1] == "summary") ) {
                print;
            }
            getline;
        } \
        i = getline;  \
        while (i > 0) { \
            if (substr($0, 1, 3) == "## ") {
                do {
                    if (substr($0, )
                    print; \



                    i = getline; \
                    if (match($0, "<div>")) {
                        exit;
                    } \
                } while  ((i > 0) && (substr($0, 1, 3) != "## "));
                print "--------------------------------------";
            } else {
                i = getline;
            }
        } \
    print "\n   ==> Finished processing ", FILENAME, "\n" > "/dev/tty"; \
    } else { \
        print " **** ", FILENAME, " DOES NOT START WITH YAML FRONTMATTER! ***\n" > "/dev/tty";
        exit;
    }\
}
