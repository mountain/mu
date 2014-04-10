class Loader(Lisp):
    """ The Loader class is the interpreter driver.  It does the following:
            1. Initialize the global environment
    """
    def __init__(self):
        iostreams=(sys.stdin, sys.stdout, sys.stderr)
        (self.stdin, self.stdout, self.stderr) = iostreams

        self.debug = False
        self.verbose = True
        self.core = True
        self.closures = True

        self.rdr = Reader()

    def handle_expr(self, environment, sexpr):
        try:
            return sexpr.eval(environment)
        except ValueError as err:
            print(err)
            return FALSE

    def handle(self, environment, source):
        sexpr = self.rdr.get_sexpr(source)

        while sexpr:
            result = None

            try:
                result = self.handle_expr(environment, sexpr)
            except Error as err:
                print(err)

            if self.verbose:
                self.stdout.write("    %s\n" % result)

            sexpr = self.rdr.get_sexpr()


    def get_complete_command(self, environment, line="", depth=0):
        if line != "":
            line = line + " "

        if self.environment.level != 0:
            prompt = PROMPT + " %i%s " % (environment.level, DEPTH_MARK * (depth+1))
        else:
            if depth == 0:
                prompt = PROMPT + "> "
            else:
                prompt = PROMPT + "%s " % (DEPTH_MARK * (depth+1))

            line = line + self.read_line(prompt)

            # Used to balance the parens
            balance = 0
            for ch in line:
                if ch == "(":
                    # This is not perfect, but will do for now
                    balance = balance + 1
                elif ch == ")":
                    # Too many right parens is a problem
                    balance = balance - 1
            if balance > 0:
                # Balanced parens gives zero
                return self.get_complete_command(line, depth+1)
            elif balance < 0:
                raise ValueError("Invalid paren pattern")
            else:
                return line

    def load(self, environment, files):
        self.verbose = False

        for filename in files:
            infile = open(filename, 'r')
            self.stdin = infile

            source = self.get_complete_command(environment)
            while(source not in ["EOF"]):
                self.process(source)

                source = self.get_complete_command(environment)

            infile.close()
        self.stdin = sys.stdin

        self.verbose = True
