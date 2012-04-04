currentTree = null


# JS object with some feature to add easily properties from a string 
# representation.
# JS object with properties like this :
# 
# root:
#   todo: {}
#   recipe:
#     dessert:
#       brownie: {}
#
# could be created with this code :
# tree = new Tree
# tree.addNode "todo"
# tree.addNode "recipe/dessert/brownie"
#
class exports.Tree

    # All trees have a root property called root
    constructor: ->
        @root = {}

    # Add a node to the tree. It needs the complete path to add a node.
    # If parent nodes does not exist, they are created too.
    addNode: (path) ->
        nodes = path.split("/")

        currentNode = @root
        for pathNode in nodes
            if currentNode[pathNode] != undefined
                currentNode = currentNode[pathNode]
            else
                currentNode[pathNode] = {}
                currentNode = currentNode[pathNode]
        this

     # If exitsts, deletes node located at given path, else do nothing
    deleteNode: (path) ->
        nodes = path.split("/")

        currentNode = @getNode path, 1
        delete currentNode[nodes.pop()] if currentNode != undefined

        this
        
    # Get node set at given path. Retrieve parent if limit = 1, great-parent
    # if limit = 2, ...
    # Default limit is 0
    getNode: (path, limit) ->
        limit = 0 if limit == undefined
        nodes = path.split("/")

        currentNode = @root
        while currentNode != undefined and nodes.length > limit
            currentNode = currentNode[nodes.shift()]
        
        currentNode

    # Json representation of the tree
    toJson: ->
        JSON.stringify(@)

