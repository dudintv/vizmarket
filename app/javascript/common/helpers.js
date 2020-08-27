export function setObjectPropByPath (object, path, value) {
  if (path.length === 1) object[path[0]] = value
  else if (path.length === 0) throw error
  else {
     if (object[path[0]])
        return setObjectPropByPath(object[path[0]], path.slice(1), value)
     else {
        object[path[0]] = {}
        return setObjectPropByPath(object[path[0]], path.slice(1), value)
     }
  }
}

export function renameObjectKey (object, oldKeyName, newKeyName) {
   if (object.hasOwnProperty(oldKeyName) && oldKeyName !== newKeyName) {
      Object.defineProperty(object, newKeyName,
            Object.getOwnPropertyDescriptor(object, oldKeyName));
      delete object[oldKeyName];
   }
}
