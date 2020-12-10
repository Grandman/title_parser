class FakeClient
  def get_body_from_url(url)
    "<html><head><title>#{url}</title></html>"
  end
end
