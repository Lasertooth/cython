cimport cython

cdef class CBase(object):
    cdef int a
    cdef c_method(self):
        return "CBase"
    cpdef cpdef_method(self):
        return "CBase"

class PyBase(object):
    def py_method(self):
        return "PyBase"

@cython.binding(True)
cdef class BothBound(CBase, PyBase):
    cdef dict __dict__
    """
    >>> b = Both()
    >>> b.py_method()
    'PyBase'
    >>> b.cp_method()
    'Both'
    >>> b.call_c_method()
    'Both'

    >>> isinstance(b, CBase)
    True
    >>> isinstance(b, PyBase)
    True
    """
    cdef c_method(self):
        return "Both"
    cpdef cp_method(self):
        return "Both"
    def call_c_method(self):
        return self.c_method()

cdef class BothSub(BothBound):
    """
    >>> b = BothSub()
    >>> b.py_method()
    'PyBase'
    >>> b.cp_method()
    'Both'
    >>> b.call_c_method()
    'Both'
    """
    pass

@cython.binding(False)
cdef class BothUnbound(CBase, PyBase):
    cdef dict __dict__
    """
    >>> b = Both()
    >>> b.py_method()
    'PyBase'
    >>> b.cp_method()
    'Both'
    >>> b.call_c_method()
    'Both'

    >>> isinstance(b, CBase)
    True
    >>> isinstance(b, PyBase)
    True
    """
    cdef c_method(self):
        return "Both"
    cpdef cp_method(self):
        return "Both"
    def call_c_method(self):
        return self.c_method()
