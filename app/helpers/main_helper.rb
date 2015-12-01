module MainHelper
  def page_by_lang lang
    return request.fullpath.sub(/^\/(ru|en)\/?/, "/#{lang}/") if request.fullpath.scan(/^\/(ru|en)\/?/).length > 0
    "/#{lang}#{request.fullpath}"
  end
end
