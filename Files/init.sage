_ = var('a b c d s t u v y z')
_ = var('k m n p q', domain=ZZ)

f = function('f')(x)
g = function('g')(x)
h = function('h')(x)

try:
    import numpy as np

    def rad2deg(x, /):
        return np.rad2deg(float(x))

    def deg2rad(x, /):
        return np.deg2rad(float(x))

except ModuleNotFoundError:
    pass

%display unicode_art
