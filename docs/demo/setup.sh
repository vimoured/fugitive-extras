#!/bin/sh
# The repository the GIFs show, in a new directory; prints its path.
#   main:     one commit, then one more after the branch forked
#   discount: two commits, plus uncommitted changes in cart.py and tax.py
set -e
dir=$(mktemp -d)/shop
mkdir -p "$dir"
cd "$dir"
git init -q -b main
git config user.name demo
git config user.email demo@example.com

cat >cart.py <<'PY'
def total(items):
    amount = 0
    for item in items:
        amount += item.price
    return amount


def label(item):
    return item.name


def count(items):
    return len(items)
PY
cat >tax.py <<'PY'
RATE = 0.2


def tax(amount):
    return amount * RATE
PY
git add . && git commit -q -m "Cart and tax"

git checkout -q -b discount
sed -i.bak 's/^def total(items):/def total(items, discount=0):/; s/^    return amount$/    return amount - discount/' cart.py
rm -f cart.py.bak
git commit -qam "Take a discount off the total"
sed -i.bak 's/^RATE = 0.2/RATE = 0.25/' tax.py
sed -i.bak 's/^    return item.name$/    return item.name.title()/' cart.py
rm -f tax.py.bak cart.py.bak
git commit -qam "Raise the tax rate, title-case labels"

git checkout -q main
cat >shipping.py <<'PY'
def shipping(weight):
    return weight * 2
PY
git add . && git commit -q -m "Main moves on: shipping"
git checkout -q discount

# Not committed: one change at the top of cart.py, one at the bottom, one in tax.py
sed -i.bak 's/^    amount = 0$/    amount = 0.0/; s/^    return len(items)$/    return sum(1 for _ in items)/' cart.py
sed -i.bak 's/^    return amount \* RATE$/    return round(amount * RATE, 2)/' tax.py
rm -f cart.py.bak tax.py.bak
printf '%s\n' "$dir"
