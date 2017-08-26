public class PageBean{
  private int totalPage;
  private int currentPage;
  private List<Hero> shows = new ArrayList<Hero>();
  public PageBean(){
  } 
  public PageBean(int currentPage,int totalPage){
    this.totalPage = totalPage;
    this.currentPage = currentPage;
  }
  public List<Hero> getShows(){
    return shows;
  }
  public void setTotalPage(int totalPage){
    this.totalPage = totalPage;
  }
  public int getTotalPage(){
    return totalPage;
  }
  public void setCurrentPage(int currentPage){
    this.currentPage = currentPage;
  }
  public int getCurrentPage(){
  return currentPage;
  }
}