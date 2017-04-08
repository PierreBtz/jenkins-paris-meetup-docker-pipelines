import { JenkinsParisMeetupDockerPipelinesPage } from './app.po';

describe('jenkins-paris-meetup-docker-pipelines App', () => {
  let page: JenkinsParisMeetupDockerPipelinesPage;

  beforeEach(() => {
    page = new JenkinsParisMeetupDockerPipelinesPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
