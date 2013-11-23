  ##
  #TODO: Re-word the responses to be human readable.

module MovieDB
 module MovieError
   def raise_errors(response)
     case response.to_i
       when 200
        raise OK, "(#{response}: Successful )"
       when 404
         raise NotFound, "(#{response}: Resource Not found)"
       when 500
         raise Lookup, "(#{response}: Internal Server Error.)"
       when 503
         raise Unavailable, "(#{response}: Resource is Unavailable.)"
       else
     end
   end
 end
end
