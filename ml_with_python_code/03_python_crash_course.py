# Python Crash Course


# Assignment
# ==========

# Strings
data = 'hello world'
print(data[0])
print(len(data))
print(data)

# Numbers
value = 123.1
print(value)
value = 10
print(value)

# Boolean
a = True
b = False
print(a, b)

# Multiple Assignment
a, b, c = 1, 2, 3
print(a, b, c)

# No value
a = None
print(a)



# Flow Control
# ============

# If-Then-Else

value = 99
if value >= 99:
	print 'That is fast'
elif value > 200:
	print 'That is too fast'
else:
	print 'That that is safe'

# For-Loop
for i in range(10):
	print i

# While-Loop
i = 0
while i < 10:
	print i
	i += 1


# Data Structures
# ===============

# Tuple (cannot change)
a = (1, 2, 3)
print a


# Lists
mylist = [1, 2, 3]
print("Zeroth Value: %d") % mylist[0]
mylist.append(4)
print("List Length: %d") % len(mylist)
for value in mylist:
	print value



# Dictionaries

mydict = {'a': 1, 'b': 2, 'c': 3}
print("A value: %d") % mydict['a']
mydict['a'] = 11
print("A value: %d") % mydict['a']
print("Keys: %s") % mydict.keys()
print("Values: %s") % mydict.values()
for key in mydict.keys():
	print mydict[key]


# Functions
# ===========

# Sum function
def mysum(x, y):
	return x + y

# Test sum function
mysum(1, 3)


