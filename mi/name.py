from os.path import join

from interface import Eval, Egal
from env import Environment

# We try to introduce a clojure-like namespace in mu
#

class NamedEntity(Eval):
    def __init__(self, scope, name, entity):
        self.scope = scope
        self.name = name
        self.entity = entity

    def __repr__(self):
        return self.qname()

    def scope(self):
        return self.scope

    def name(self):
        return self.name

    def entity(self):
        return self.entity

    def qname(self):
        return "%s/%s" % (self.scope.qname(), self.name)

class NamedSpace():
    def __init__(self, par, name):
        self.parent = par
        self.name = name

    def __repr__(self):
        return self.qname()

    def qname(self):
        return "%s.%s" % (self.parent.qname(), self.name)

    def path(self):
        return join(self.parent.path(), self.name)

    def enviroment(self):
        par_env = self.parent.enviroment()
        return Environment(par_env, {})

class NamedScope(NamedSpace):
    def __init__(self, par, name):
        NamedSpace.__init__(self, par, name)

    def enviroment(self):
        par_env = self.parent.enviroment()
        mu = par_env.get("__mu__")
        mu.process(self.path())
        return Environment(par_env, bnds)

